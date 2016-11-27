//
//  Colony.swift
//  Colony
//
//  Created by Ido Tamir on 9/14/16.
//  Copyright © 2016 Ido Tamir. All rights reserved.
//

import Foundation
import UIKit

///A class that represents a Game of Life colony
class Colony: CustomStringConvertible{
    
    //MARK: Variables
    
    ///A set that contains all the alive cells that are in the colony
    var aliveCells: Set<Cell>;
    ///The CGRect that represents the colony dimensions
    var rect:CGRect;
    ///The name of the colony
    var name: String?;
    ///The minimum x coordinate of the colony
    var xMin: Int {return Int(rect.minX)};
    ///The minimum y coordinate of the colony
    var yMin: Int {return Int(rect.minY)};
    ///The width of the colony
    var width: Int {return Int(rect.width)};
    ///The height of the colony
    var height: Int {return Int(rect.height)};
    ///The current generation number
    var generation: Int;
    ///description value of the full colony, the string representation of a Game of Life colony
    var description: String{
        return printWindow(xMin, yMin: yMin, width: width, height: height);
    }
    ///Details needed for UITableCell
    var details: String{
        return "width: \(width), height: \(height), Gen #\(generation)"
    }
    
    
    //MARK: Initializer
    
    /**
     Initializes a Colony with:
     
     1. zero alive cells
     2. **rect** with properties listed below
     3. **width** equal to 20
     4. **height** equal to 20
     5. **generation** equal to 0
     6. **xMin** equal to 1
     7. **yMin** equal to 1
     */
    init(){
        aliveCells = Set();
        rect = CGRect(x: 1, y: 1, width: 20, height: 20);
        generation = 0;
    }
    
    /**
     Initializes a square Colony with:
     
     1. zero alive cells
     2. **rect** with properties listed below
     3. **width** equal to *dimensions*
     4. **height** equal to *dimensions*
     5. **generation** equal to 0
     6. **xMin** equal to 1
     7. **yMin** equal to 1
     
     - Parameter dimensions: The **width** and **height** of the colony
     */
    init(dimensions: Int){
        aliveCells = Set();
        rect = CGRect(x: 1, y: 1, width: dimensions, height: dimensions);
        generation = 0;
    }
    
    /**
     Initializes a Colony with:
     
     1. zero alive cells
     2. **rect** with properties listed below
     3. **width** equal to *width*
     4. **height** equal to *height*
     5. **generation** equal to 0
     6. **xMin** equal to 1
     7. **yMin** equal to 1
     
     - Parameter width: The **width** of the colony
     - Parameter height: The **height** of the colony
     */
    init(width: Int, height: Int){
        aliveCells = Set();
        rect = CGRect(x: 1, y: 1, width: width, height: height);
        generation = 0;
    }
    
    /*
     Initializes a Colony with:

     1. zero alive cells
     2. **rect** with properties listed below
     3. **width** equal to *width*
     4. **height** equal to *height*
     5. **generation** equal to 0
     6. **xMin** equal to *xMin*
     7. **yMin** equal to *yMin*
     
     - Parameter xMin: The minimum x coordinate of the colony
     - Parameter yMin: The minimum y coordinate of the colony
     - Parameter width: The **width** of the colony
     - Parameter height: The **height** of the colony
     */
    
    init(xMin: Int, yMin: Int, width: Int, height: Int){
        aliveCells = Set();
        rect = CGRect(x: xMin, y: yMin, width: width, height: height);
        generation = 0;
    }
    
    //MARK: Printers
    
    /**
     A function to display a rich textual representation of a specific area of the colony
     
     - Parameter xMin: The minimum x coordinate of the textual representation of the colony
     - Parameter xMax: The maximum x coordinate of the textual representation of the colony
     - Parameter yMin: The minimum y coordinate of the textual representation of the colony
     - Parameter yMax: The maximum y coordinate of the textual representation of the colony
     - Remark: All parameters must be given as `Int`
     SeeAlso: `printWindowBasic(xMin: Int, yMin: Int, width: Int, height: Int) -> String'
     - Returns: A string representation of the specific area of the colony
     */
    func printCustomWindow(_ xMin: Int, yMin: Int, xMax: Int, yMax: Int) -> String{
        let width = xMax - xMin + 1;
        let height = yMax - yMin + 1;
        return printWindow(xMin, yMin: yMin, width: width, height: height);
    }
    
    /**
     A function to display a rich textual representation of a specific area of the colony
     
     - Parameter xMin: The minimum x coordinate of the textual representation of the colony
     - Parameter xMax: The maximum x coordinate of the textual representation of the colony
     - Parameter width: The width of the window to be printed
     - Parameter height: The height of the window to be printed
     - Remark: All parameters must be given as `Int`
     SeeAlso: `printWindowBasic(xMin: Int, yMin: Int, width: Int, height: Int) -> String'
     - Returns: A string representation of the specific area of the colony
     */
    func printCustomWindow(_ xMin: Int, yMin: Int, width: Int, height: Int) -> String{
        return printWindow(xMin, yMin: yMin, width: width + 1, height: height + 1)
    }
    
    /**
     A function to display a rich textual representation of a specific area of the colony
     
     - Parameter xMin: The minimum x coordinate of the textual representation of the colony
     - Parameter yMin: The minimum y coordinate of the textual representation of the colony
     - Parameter width: The width of the window to be printed
     - Parameter height: The height of the window to be printed
     - Remark: All parameters must be given as `Int`
     - Returns: A string representation of the specific area of the colony
     - SeeAlso: `printWindowBasic(xMin: Int, yMin: Int, width: Int, height: Int) -> String'
     */
    fileprivate func printWindow(_ xMin: Int, yMin: Int, width: Int, height: Int) -> String{
        let yMax = yMin + height;
        let maxHeight = yMax.description.length > yMin.description.length ?
            yMax.description.length: yMin.description.length;
        var s: String = "Generation #\(generation)\n\n";
        for row in 1...height{
            for column in xMin..<(width + xMin){
                
                let c: Cell = Cell(xCoor: column, yCoor: yMax - row);
                let offset: String;
                if column == xMin {
                    offset = "\n" + "\(yMax - row)".fit(length: maxHeight) + "|";
                }else{
                    offset = "";
                }
                s += offset + c.textString(isCellAlive(c));
            }
        }
        let xValues = (xMin...(width + xMin - 1)).map({"\($0)"})
        for i in 0...xValues.last!.length{
            s += xValues.reduce("\n" + "".fit(length: maxHeight + 1), {
                $0 + ($1.length > i ? "\($1[i])" : " ");
            });
        }
        /*
         How to do this parallel: Too long and hard to understand
         var s = range.reduce("Generation #\(generation)\n\n", combine: {
         let y: Int = $1 / width;
         let x: Int = $1 % width;
         let c: Cell = Cell(xCoor: x + xMin, yCoor: y + yMin);
         let column: String;
         if x == 0 {
         column = "\n" + "\(y + yMin)".fit(length: maxHeight) + "|";
         }else{
         column = "";
         }
         return $0 + column + c.textString(isCellAlive(c))
         });*/
        return s;
    }
    
    /**
     A function to display a basic textual representation of a specific area of the colony
     
     - Parameter xMin: The minimum x coordinate of the textual representation of the colony
     - Parameter yMin: The minimum y coordinate of the textual representation of the colony
     - Parameter width: The width of the window to be printed
     - Parameter yMax: The height of the window to be printed
     - Remark: All parameters must be given as `Int`
     - Returns: A string representation of the specific area of the colony
     - SeeAlso: `printWindow(xMin: Int, yMin: Int, width: Int, height: Int) -> String'
     */
    func printWindowBasic(_ xMin: Int, yMin: Int, width: Int, height: Int) -> String{
        let range = 0..<(height * width)
        return range.reduce("Generation #\(generation)\n\n", {
            let y: Int = $1 / width;
            let x: Int = $1 % width;
            let c: Cell = Cell(xCoor: x + xMin, yCoor: y + yMin);
            return $0 + (x == 0 ? "\n" : "") + "\(c.textString(isCellAlive(c)))"
        });
    }
    
    /**
     A function that returns the rectangular bounds of colony
     
     - Returns: A `CGRect` that represents the rectangle that encompasses the alive colony
     - Remark: The coordinates are ordered counterclockwise from the top left corner
     of the rectangle
     */
    func rectangleBound() -> CGRect{
        let xMin = aliveCells.min(by: {$0.xCoor < $1.xCoor})!.xCoor;
        let xMax = aliveCells.max(by: {$0.xCoor < $1.xCoor})!.xCoor
        let yMin = aliveCells.min(by: {$0.yCoor < $1.yCoor})!.yCoor
        let yMax = aliveCells.max(by: {$0.yCoor < $1.yCoor})!.yCoor
        return CGRect(x: xMin, y: yMin, width: xMax - xMin, height: yMax - yMin);
    }
    
    //MARK: Basic Colony Accessors
    
    /**
     Makes a given cell alive
     
     - Parameter xCoor: x coordinate of cell
     - Parameter yCoor: y coordinate of cell
     */
    func setCellAlive(_ xCoor: Int, yCoor: Int){
        aliveCells.insert(Cell(xCoor: xCoor, yCoor: yCoor));
    }
    
    /**
     Turns a given cell dead
     
     - Parameter xCoor: x coordinate of cell
     - Parameter yCoor: y coordinate of cell
     */
    func setCellDead(_ xCoor: Int, yCoor: Int){
        aliveCells.remove(Cell(xCoor: xCoor, yCoor: yCoor));
    }
    
    /**
     Resets the cell (sets all the cells to dead)
     */
    func resetColony(){
        aliveCells.removeAll()
    }
    
    /**
     Checks if a cell is alive
     
     - Parameter xCoor: x coordinate of cell
     - Parameter yCoor: y coordinate of cell
     - Returns: `true` if the cell is alive, `false` if the cell is dead
     - SeeAlso: `isCellAlive(c: Cell) -> Bool`
     */
    func isCellAlive(_ xCoor: Int, yCoor:Int ) -> Bool{
        return aliveCells.contains(Cell(xCoor: xCoor, yCoor: yCoor));
    }
    
    /**
     Checks if a cell is alive
     
     - Parameter c: the cell that will be checked
     - Returns: `true` if the cell is alive, `false` if the cell is dead
     - SeeAlso: `isCellAlive(xCoor: Int, yCoor:Int ) -> Bool`
     */
    func isCellAlive(_ c: Cell) -> Bool{
        return aliveCells.contains(c);
    }
    
    /**
     Sets cell alive or dead based on parameters
     
     - Parameter alive: whether to make the cell alive or dead
     - Parameter xCoor: x coordinate of cell
     - Parameter yCoor: y coordinate of cell
     */
    func setCell(alive: Bool, xCoor: Int, yCoor: Int) {
        if alive {
            setCellAlive(xCoor, yCoor: yCoor)
        }else{
            setCellDead(xCoor, yCoor: yCoor)
        }
    }
    
    
    /**
     Evolves the colony one generation
     */
    func evolve(){
        let nextGenCells = aliveCells
            .flatMap({findAllNeighbors($0)})
            .filter({willBeAlive($0)})
        generation += 1;
        aliveCells = Set(nextGenCells);
    }
    
    /**
     Evolves the colony multiple times
     
     - Parameter generations: how many generations to evolve the colony
     */
    func evolve(_ generations: Int){
        for _ in 1...generations{
            evolve();
        }
    }
    
    /**
     Evolves one specific cell
     
     - Parameter nextGenCells: the set of cells that will be alive the next generation
     - Parameter c: the cell to check if it will be alive
     - Parameter neighbors: the amount of alive neighbors the cell has
     - Returns: a copy of nextGenCells updated with the new cell if the new cell will be alive
     - Remark: This function is very inefficient because it can't change nextGenCells so it makes a
     copy of it. An alternative is to use the & operator to allow it to change but that destroys
     parallel optimizations
     */
    func evolveCell(_ nextGenCells: Set<Cell>, c: Cell, neighbors: Int) -> Set<Cell>{
        var updatedNextGenCells = nextGenCells;
        if willBeAlive(c, neighbors: neighbors, isAlive: aliveCells.contains(c)){
            updatedNextGenCells.insert(c);
            return updatedNextGenCells;
        }
        return nextGenCells;
    }
    
    //MARK: Helper Functions
    
    /**
     Helps evolve a single cell
     
     - Parameter nextGenCells: set of cells that will be alive in the next generation
     - Parameter c: The cell that will be checked
     - Returns: a copy of nextGenCells updated with the new cell if the new cell will be alive
     - SeeAlso: `func evolveCell(nextGenCells: Set<Cell>, c: Cell, neighbors: Int) -> Set<Cell>`
     */
    func evolveCellHelper(_ nextGenCells: Set<Cell>, c:Cell) -> Set<Cell>{
        return evolveCell(nextGenCells, c: c, neighbors: findAliveNeighborsOf(c).count);
    }
    
    /**
     Checks if a cell will be alive in the next generation
     
     - Parameter c: The cell that is being checked
     - Returns: `true` if the cell will be alive, `false` otherwise
     - Remark: [Game of Life Rules](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life#Rules)
     */
    func willBeAlive(_ c: Cell) -> Bool{
        let neighborCount = findAliveNeighborsOf(c).count
        let isAlive = aliveCells.contains(c);
        return willBeAlive(c, neighbors: neighborCount, isAlive: isAlive);
    }
    
    
    /**
     Checks if a cell will be alive in the next generation
     
     - Parameter c: The cell that is being checked
     - Parameter neighbors: The amount of alive neighbors the cell has
     - Parameter isAlive: If the cell is currently alive
     - Returns: `true` if the cell will be alive, `false` otherwise
     - Remark: [Game of Life Rules](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life#Rules)
     */
    func willBeAlive(_ c: Cell, neighbors: Int, isAlive: Bool) -> Bool{
        return (neighbors == 3) || (neighbors == 2 && isAlive);
    }
    
    /**
     Finds all the alive neighbors of the cell
     
     - Parameter cell: the cell whose alive neighbors will be returned
     - Returns:
     */
    func findAliveNeighborsOf(_ cell: Cell) -> [Cell]{
        return aliveCells.filter({isNeighbor(cell, c2: $0)});
    }
    /**
     Finds all the neighbors of the cell
     
     - Parameter cell: the cell whose neighbors will be found
     - Returns: an array of the neighboring cells
     */
    func findAllNeighbors(_ cell: Cell) -> [Cell]{
        let x = cell.xCoor;
        let y = cell.yCoor;
        return Array(arrayLiteral:
            Cell(xCoor: x - 1, yCoor: y + 1),
                     Cell(xCoor: x - 1, yCoor: y),
                     Cell(xCoor: x - 1, yCoor: y - 1),
                     Cell(xCoor: x, yCoor: y + 1),
                     Cell(xCoor: x, yCoor: y),
                     Cell(xCoor: x, yCoor: y - 1),
                     Cell(xCoor: x + 1, yCoor: y + 1),
                     Cell(xCoor: x + 1, yCoor: y),
                     Cell(xCoor: x + 1, yCoor: y - 1))
            .filter({withinBounds($0)});
    }
    
    /**
     Finds if a cell is within the bounds of the colony
     
     - Parameter cell: the cell that will be checked
     - Returns: `true` if the cell is within bounds `false` otherwise
     */
    func withinBounds(_ cell: Cell) -> Bool{
        let x = cell.xCoor;
        let y = cell.yCoor;
        let xRange = xMin...width;
        let yRange = yMin...height
        return (xRange ~= x) && (yRange ~= y);
    }
    
    /**
     Checks if two cells are neighbors
     
     - Parameter c1: one of the cells to be checked
     - Parameter c2: the other neighbor to be checked
     - Returns: `true` if the two cells are neighbors, `false` otherwise
     */
    func isNeighbor(_ c1: Cell, c2: Cell) -> Bool{
        let x = c2.xCoor;
        let y = c2.yCoor;
        let xRange = (c1.xCoor - 1)...(c1.xCoor + 1);
        let yRange = (c1.yCoor - 1)...(c1.yCoor + 1);
        return (xRange ~= x) && (yRange ~= y) && c1 != c2;
    }
    
    func standardSet(c: Colony){
        c.setCellAlive(5, yCoor: 3)
        c.setCellAlive(5, yCoor: 4)
        c.setCellAlive(5, yCoor: 5)
        c.setCellAlive(4, yCoor: 3)
        c.setCellAlive(3, yCoor: 4)

}
    
    func glider(c: Colony) {
        c.setCellAlive(2, yCoor: 2)
        c.setCellAlive(3, yCoor: 3)
        c.setCellAlive(3, yCoor: 4)
        c.setCellAlive(4, yCoor: 2)
        c.setCellAlive(4, yCoor: 3)
    }
    
    func pulsar(c: Colony) {
        //top left top horizantal
        c.setCellAlive(5, yCoor: 3)
        c.setCellAlive(6, yCoor: 3)
        c.setCellAlive(7, yCoor: 3)
        //top left left vertical
        c.setCellAlive(3, yCoor: 5)
        c.setCellAlive(3, yCoor: 6)
        c.setCellAlive(3, yCoor: 7)
        //top left bottom horizantal
        c.setCellAlive(5, yCoor: 8)
        c.setCellAlive(6, yCoor: 8)
        c.setCellAlive(7, yCoor: 8)
        //top left right vertical
        c.setCellAlive(8, yCoor: 5)
        c.setCellAlive(8, yCoor: 6)
        c.setCellAlive(8, yCoor: 7)
        //Bottom left top horizantal
        c.setCellAlive(5, yCoor: 10)
        c.setCellAlive(6, yCoor: 10)
        c.setCellAlive(7, yCoor: 10)
        //Bottom left bottom horizantal
        c.setCellAlive(5, yCoor: 15)
        c.setCellAlive(6, yCoor: 15)
        c.setCellAlive(7, yCoor: 15)
        ////Bottom left left vertical
        c.setCellAlive(3, yCoor: 11)
        c.setCellAlive(3, yCoor: 12)
        c.setCellAlive(3, yCoor: 13)
        ////Bottom left right vertical
        c.setCellAlive(8, yCoor: 11)
        c.setCellAlive(8, yCoor: 12)
        c.setCellAlive(8, yCoor: 13)
        //top right top horizantal
        c.setCellAlive(11, yCoor: 3)
        c.setCellAlive(12, yCoor: 3)
        c.setCellAlive(13, yCoor: 3)
        //top right left vertical
        c.setCellAlive(10, yCoor: 5)
        c.setCellAlive(10, yCoor: 6)
        c.setCellAlive(10, yCoor: 7)
        //top right bottom horizantal
        c.setCellAlive(11, yCoor: 8)
        c.setCellAlive(12, yCoor: 8)
        c.setCellAlive(13, yCoor: 8)
        //top right right vertical
        c.setCellAlive(15, yCoor: 5)
        c.setCellAlive(15, yCoor: 6)
        c.setCellAlive(15, yCoor: 7)
        //bottom right top horizantal
        c.setCellAlive(11, yCoor: 10)
        c.setCellAlive(12, yCoor: 10)
        c.setCellAlive(13, yCoor: 10)
        //bottom right left vertical
        c.setCellAlive(10, yCoor: 11)
        c.setCellAlive(10, yCoor: 12)
        c.setCellAlive(10, yCoor: 13)
        //bottom right bottom horizantal
        c.setCellAlive(11, yCoor: 15)
        c.setCellAlive(12, yCoor: 15)
        c.setCellAlive(13, yCoor: 15)
        //bottom right right vertical
        c.setCellAlive(15, yCoor: 11)
        c.setCellAlive(15, yCoor: 12)
        c.setCellAlive(15, yCoor: 13)

    }
    
    func pentadecathelon(c: Colony) {
        c.setCellAlive(10, yCoor: 6)
        c.setCellAlive(10, yCoor: 7)
        c.setCellAlive(9, yCoor: 7)
        c.setCellAlive(11, yCoor: 7)
        c.setCellAlive(10, yCoor: 8)
        c.setCellAlive(8, yCoor: 8)
        c.setCellAlive(9, yCoor: 8)
        c.setCellAlive(11, yCoor: 8)
        c.setCellAlive(12, yCoor: 8)
        c.setCellAlive(10, yCoor: 17)
        c.setCellAlive(10, yCoor: 16)
        c.setCellAlive(9, yCoor: 16)
        c.setCellAlive(11, yCoor: 16)
        c.setCellAlive(10, yCoor: 15)
        c.setCellAlive(8, yCoor: 15)
        c.setCellAlive(9, yCoor: 15)
        c.setCellAlive(11, yCoor: 15)
        c.setCellAlive(12, yCoor: 15)

    }
    
    func gliderGun(c: Colony){
       //possibly a glider gun
        c.setCellAlive(1, yCoor: 5)
        c.setCellAlive(1, yCoor: 6)
        c.setCellAlive(2, yCoor: 5)
        c.setCellAlive(2, yCoor: 6)
        c.setCellAlive(11, yCoor: 5)
        c.setCellAlive(11, yCoor: 6)
        c.setCellAlive(11, yCoor: 7)
        c.setCellAlive(12, yCoor: 4)
        c.setCellAlive(12, yCoor: 8)
        c.setCellAlive(13, yCoor: 3)
        c.setCellAlive(13, yCoor: 9)
        c.setCellAlive(14, yCoor: 3)
        c.setCellAlive(14, yCoor: 9)
        c.setCellAlive(15, yCoor: 6)
        c.setCellAlive(16, yCoor: 4)
        
        c.setCellAlive(16, yCoor: 8)
        c.setCellAlive(17, yCoor: 5)
        c.setCellAlive(17, yCoor: 6)
        c.setCellAlive(17, yCoor: 7)
        c.setCellAlive(18, yCoor: 6)
        
        c.setCellAlive(21, yCoor: 3)
        c.setCellAlive(21, yCoor: 4)
        c.setCellAlive(21, yCoor: 5)
        c.setCellAlive(22, yCoor: 3)
        c.setCellAlive(22, yCoor: 4)
        
        c.setCellAlive(22, yCoor: 5)
        c.setCellAlive(23, yCoor: 2)
        c.setCellAlive(23, yCoor: 6)
        
        c.setCellAlive(25, yCoor: 1)
        c.setCellAlive(25, yCoor: 2)
        c.setCellAlive(25, yCoor: 6)
        c.setCellAlive(25, yCoor: 7)
        c.setCellAlive(35, yCoor: 3)
        c.setCellAlive(35, yCoor: 4)
        c.setCellAlive(36, yCoor: 3)
        
        c.setCellAlive(36, yCoor: 4)
        c.setCellAlive(35, yCoor: 22)
        c.setCellAlive(35, yCoor: 23)
        c.setCellAlive(35, yCoor: 25)
        c.setCellAlive(36, yCoor: 22)
        
        c.setCellAlive(36, yCoor: 23)
        c.setCellAlive(36, yCoor: 25)
        c.setCellAlive(36, yCoor: 26)
        c.setCellAlive(36, yCoor: 27)
        c.setCellAlive(37, yCoor: 28)
        c.setCellAlive(38, yCoor: 22)
        c.setCellAlive(38, yCoor: 23)
        c.setCellAlive(38, yCoor: 25)
        c.setCellAlive(38, yCoor: 26)
        c.setCellAlive(38, yCoor: 27)
        c.setCellAlive(39, yCoor: 23)
        c.setCellAlive(39, yCoor: 25)
        c.setCellAlive(40, yCoor: 23)
        
        c.setCellAlive(40, yCoor: 25)
        c.setCellAlive(41, yCoor: 24)
        
        
    
    }
    
}
