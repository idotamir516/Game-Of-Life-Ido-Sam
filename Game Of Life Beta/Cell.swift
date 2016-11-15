//
//  Cell.swift
//  Colony
//
//  Created by Ido Tamir on 9/14/16.
//  Copyright © 2016 Ido Tamir. All rights reserved.
//

import Foundation

///A data structure representing a game of life cell, it contains an x coordinate and an y coordinate
struct Cell: Hashable, Equatable, CustomStringConvertible{
    
    //MARK: Specific Values
    
    ///hash value value of cell guarantees a distinct hash value
    var hashValue: Int{
        let sum: Double = Double(xCoor + yCoor);
        let value: Double = 0.5 * sum * (sum + 1) + Double(yCoor);
        return Int(value);
    }
    
    ///description value of cell returns (x coordinate, y coordinate)
    var description: String{
        return "(\(xCoor), \(yCoor))";
    }
    ///x coordinate of cell
    let xCoor: Int;
    ///y coordinate of cell
    let yCoor: Int;
    
    //MARK: Methods
    
    /**
     The Game of Life textual representation of the cell
     
     - Parameter isAlive: boolean description if cell is alive or not
     - Returns: "*" if cell is alive and " " if cell is dead
     */
    func textString(_ isAlive: Bool) -> String{
        return isAlive ? "*": " ";
    }
    
}

/**
 The equals operator for two Cell structs
 
 - Parameter lhs: left hand side Cell of the equal operator
 - Parameter rhs: right hand side Cell of the equal operator
 - Returns: true if the two cells have the exact same coordinates,
 false otherwise
 */
func == (lhs: Cell, rhs: Cell) -> Bool{
    return (lhs.xCoor == rhs.xCoor) && (lhs.yCoor == rhs.yCoor)
}
