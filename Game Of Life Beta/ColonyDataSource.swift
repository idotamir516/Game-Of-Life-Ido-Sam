//
//  ColonyDataSource.swift
//  Game Of Life Beta
//
//  Created by Ido Tamir on 11/19/16.
//  Copyright © 2016 Ido Tamir. All rights reserved.
//

import Foundation
import UIKit

///Immutable colony to be used as a data source for views
struct  ColonyDataSource {
    ///Colony to be represented
    private let colony: Colony;
    
    ///The cells which are alive in the colony
    var aliveCells: Set<Cell> {return colony.aliveCells};
    
    ///The CGRect that represents the colony dimensions
    var rect:CGRect{return colony.rect};
    ///The minimum x coordinate of the colony
    var xMin: Double {return Double(rect.minX)};
    ///The minimum y coordinate of the colony
    var yMin: Double {return Double(rect.minY)};
    ///The width of the colony
    var width: Double {return Double(rect.width)};
    ///The height of the colony
    var height: Double {return Double(rect.height)};
    
    
    init(){colony = Colony()}
    init(colony: Colony){self.colony = colony};
}
