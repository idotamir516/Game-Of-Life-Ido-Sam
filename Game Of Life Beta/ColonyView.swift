//
//  ColonyView.swift
//  Game Of Life Beta
//
//  Created by Ido Tamir on 11/19/16.
//  Copyright © 2016 Ido Tamir. All rights reserved.
//

import Foundation
import UIKit

class ColonyView: UIView{
    var colonyData: ColonyDataSource!;
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            //Set background to gray (for non alive cells)
            context.setFillColor(UIColor.green.cgColor)
            context.addRect(rect)
            
            //Add alive cells
            context.setFillColor(UIColor.green.cgColor);
            
            let width = Int(rect.width);
            let height = Int(rect.height);
            
            let unitWidth = width / colonyData.width;
            let unitHeight = height / colonyData.height;
            
            for cell in colonyData.aliveCells{
                let x = cell.xCoor;
                let y = cell.yCoor;
                
                let point = CGPoint(x: unitWidth * (x - colonyData.xMin),
                                    y: height - unitHeight * (y - colonyData.yMin))
                let size = CGSize(width: unitWidth, height: unitHeight);
                
                let cellRect = CGRect(origin: point, size: size)
                
                context.addRect(cellRect);
            }
            
            //Adding grid lines
            
            //Adding horizental lines
            for i in 0...colonyData.height{
                let startingPoint = CGPoint(x: 0, y: i * unitHeight)
                let endingPoint = CGPoint(x: width, y: i * unitHeight)
                context.addLines(between: [startingPoint, endingPoint])
            }
            
            //Adding vertical lines
            for i in 0...colonyData.width{
                let startingPoint = CGPoint(x: i * unitWidth, y: 0)
                let endingPoint = CGPoint(x: height, y: i * unitWidth)
                context.addLines(between: [startingPoint, endingPoint])
            }
            
            
            
            
            
            
            
            
            
        }
    }
}
