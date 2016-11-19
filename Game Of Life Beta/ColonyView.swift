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
            context.setFillColor(UIColor.darkGray.cgColor)
            context.addRect(rect)
            context.drawPath(using: .fillStroke)
            
            //Add alive cells
            context.setFillColor(UIColor.green.cgColor);
            
            let width: Double = Double(rect.width);
            let height: Double = Double(rect.height);
            
            let unitWidth: Double = width / colonyData.width;
            let unitHeight: Double = height / colonyData.height;
            
            for cell in colonyData.aliveCells{
                let x = Double(cell.xCoor);
                let y = Double(cell.yCoor);
                
                let point = CGPoint(x: unitWidth * (x - colonyData.xMin),
                                    y: height - unitHeight * (y - colonyData.yMin + 1))
                let size = CGSize(width: unitWidth, height: unitHeight);
                
                let cellRect = CGRect(origin: point, size: size)
                
                context.addRect(cellRect);
            }
            context.drawPath(using: .fillStroke)
            
            //Adding grid lines
            
            //Adding horizental lines
            for i in 0.0...colonyData.height{
                let startingPoint = CGPoint(x: 0, y: Double(i) * unitHeight)
                let endingPoint = CGPoint(x: width, y: Double(i) * unitHeight)
                context.addLines(between: [startingPoint, endingPoint])
            }
            
            //Adding vertical lines
            for i in 0.0...colonyData.width{
                let startingPoint = CGPoint(x: i * unitWidth, y: 0)
                let endingPoint = CGPoint(x: i * unitWidth, y: height)
                context.addLines(between: [startingPoint, endingPoint])
            }
            
            context.drawPath(using: .stroke)
            
            
        }
    }
}
