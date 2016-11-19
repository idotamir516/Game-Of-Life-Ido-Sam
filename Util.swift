//
//  Util.swift
//  Colony
//
//  Created by Ido Tamir on 9/17/16.
//  Copyright © 2016 Ido Tamir. All rights reserved.
//

import Foundation

///Extension to string to add syntactic sugar
extension String{
    ///A variable representing the length of the string (character count)
    var length: Int {
        return characters.count;
    }
    
    /**
     A function that returns the string index from an integer value of the index
     so getting a value from a string will be easier
     
     - Parameter n: Integer value of the index
     - Returns: the string index
     */
    func getIndexAt(_ n: Int) -> Index{
        return characters.index(startIndex, offsetBy: n);
    }
    
    /**
     A special form of ***stringByPaddingToLength*** starting from the first index and adding
     additional spaces as needed
     
     - Parameter length: the length of the desired string
     - Returns: The string in the proper length
     */
    func fit(length: Int) -> String{
        let spaces = "                                                               ";
        return padding(toLength: length, withPad: spaces, startingAt: 1);
    }
    
    ///A subscript allowing access of a string character more cleanly
    subscript(index: Int) -> Character {
        return self[getIndexAt(index)];
    }
    
}


infix operator ...

func ... (lhs: Double, rhs: Double) -> StrideTo<Double>{
    return stride(from:lhs, to: rhs, by: 1);
}
