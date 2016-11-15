//
//  Colony.swift
//  Colony
//
//  Created by Ido Tamir on 9/14/16.
//  Copyright © 2016 Ido Tamir. All rights reserved.
//

import Foundation

///A class that represents a Game of Life colony
class Colony: CustomStringConvertible{
    
    //MARK: Variables
    
    ///A set that contains all the alive cells that are in the colony
    var aliveCells: Set<Cell>;
    ///The minimum x coordinate of the colony
    var xMin: Int;
    ///The minimum y coordinate of the colony
    var yMin: Int;
    ///The width of the colony
    var width: Int;
    ///The height of the colony
    var height: Int;
    ///The current generation number
    var generation: Int;
    ///description value of the full colony, the string representation of a Game of Life colony
    var description: String{
        return printWindow(xMin, yMin: yMin, width: width, height: height);
    }
    
    //MARK: Initializer
    
    /**
     Initializes a Colony with:
     
     1. zero alive cells
     2. **width** equal to 20
     3. **height** equal to 20
     4. **generation** equal to 0
     5. **xMin** equal to 1
     6. **yMin** equal to 1
     */
    init(){
        aliveCells = Set();
        xMin = 1;
        yMin = 1;
        width = 20;
        height = 20;
        generation = 0;
    }
    
    /**
     Initializes a square Colony with:
     
     1. zero alive cells
     2. **width** equal to *dimensions*
     3. **height** equal to *dimensions*
     4. **generation** equal to 0
     5. **xMin** equal to 1
     6. **yMin** equal to 1
     
     - Parameter dimensions: The **width** and **height** of the colony
     */
    init(dimensions: Int){
        aliveCells = Set();
        xMin = 1;
        yMin = 1;
        width = dimensions;
        height = dimensions;
        generation = 0;
    }
    
    /**
     Initializes a Colony with:
     
     1. zero alive cells
     2. **width** equal to *width*
     3. **height** equal to *height*
     4. **generation** equal to 0
     5. **xMin** equal to 1
     6. **yMin** equal to 1
     
     - Parameter width: The **width** of the colony
     - Parameter height: The **height** of the colony
     */
    init(width: Int, height: Int){
        aliveCells = Set();
        xMin = 1;
        yMin = 1;
        self.width = width;
        self.height = height;
        generation = 0;
    }
    
    /*
     1. zero alive cells
     2. **width** equal to *width*
     3. **height** equal to *height*
     4. **generation** equal to 0
     5. **xMin** equal to *xMin*
     6. **yMin** equal to *yMin*
     
     - Parameter xMin: The minimum x coordinate of the colony
     - Parameter yMin: The minimum y coordinate of the colony
     - Parameter width: The **width** of the colony
     - Parameter height: The **height** of the colony
     */
    
    init(xMin: Int, yMin: Int, width: Int, height: Int){
        aliveCells = Set();
        self.xMin = xMin;
        self.yMin = yMin;
        self.width = width;
        self.height = height;
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
    
}
