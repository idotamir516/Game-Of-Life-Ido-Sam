//
//  Template.swift
//  Game Of Life Beta
//
//  Created by Samuil Agranovich on 11/16/16.
//  Copyright © 2016 Ido Tamir. All rights reserved.
//

import Foundation

struct Template {
    let colony: Colony
    
    init (c: Colony) {
        colony = c
        
    }
    init(){
        colony = Colony()
    }
    
    static func createStandardTemplates() -> [Template] {
        return [];
    }
}
