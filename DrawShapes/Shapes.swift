//
//  Shapes.swift
//  DrawShapes
//
//  Created by Trevor Murphy on 9/30/15.
//  Copyright © 2015 Trevor Murphy. All rights reserved.
//

import UIKit
import Foundation

extension CGFloat {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}

class Shapes: UIView {
    
    var whichShape: String = ""
    var sideNum: Int = 0
    let radius: CGFloat = 90
    var timesDrawn: Int = 0
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        let height = bounds.size.height
        
        let origin = CGPointMake(width/2, height/2)

        CGContextSetLineWidth(context, 1)
        
        switch whichShape {
            case "Circle":   CGContextSetStrokeColorWithColor(context,
                UIColor.redColor().CGColor)
            
            case "Triangle": CGContextSetStrokeColorWithColor(context,
                UIColor.orangeColor().CGColor)
                             sideNum = 3
            
            case "Square":   CGContextSetStrokeColorWithColor(context,
                UIColor.purpleColor().CGColor)
                             sideNum = 4
            
            case "Pentagon": CGContextSetStrokeColorWithColor(context,
                UIColor.blueColor().CGColor)
                             sideNum = 5
            
            default: CGContextSetStrokeColorWithColor(context,
                UIColor.blackColor().CGColor)
        }
        
        
        drawShapes(context!, origin: origin, nSides: sideNum, nTimes: timesDrawn)
        
    }
    
    func drawShapes(context: CGContextRef, origin: CGPoint, nSides: Int, nTimes: Int) {
        var centerOfShape = CGPoint(x: origin.x, y: origin.y - radius)
        let degreesToRotate: CGFloat = CGFloat(Double(360) / Double(timesDrawn)).degreesToRadians
        
        for _ in 0 ..< nTimes {

            if nSides == 0 {
                CGContextAddArc(context, centerOfShape.x, centerOfShape.y, radius, 0.0, CGFloat(M_PI * 2.0), 1)
            } else  {
                let shapeDegrees: CGFloat = CGFloat(360 / nSides).degreesToRadians
                var shapeVertex: CGPoint = origin; // The point that is rotated to build polygon.
                CGContextMoveToPoint(context, shapeVertex.x, shapeVertex.y)
                for _ in 0 ..< nSides {
                    let nextShapeVertex: CGPoint = rotatePoint(centerOfShape, vertex: shapeVertex, radians: shapeDegrees)
                    CGContextAddLineToPoint(context, nextShapeVertex.x, nextShapeVertex.y)
                    shapeVertex = nextShapeVertex;
                    CGContextMoveToPoint(context, shapeVertex.x, shapeVertex.y)
                }
                
            }
            CGContextStrokePath(context)
            centerOfShape = rotatePoint(origin, vertex: centerOfShape, radians: degreesToRotate)
        }
    }
    
    func rotatePoint(origin: CGPoint, vertex: CGPoint, radians: CGFloat) -> CGPoint {

        let s: CGFloat = sin(radians);
        let c: CGFloat = cos(radians);
        let x: CGFloat = ((vertex.x-origin.x) * c) - ((vertex.y-origin.y) * s) + origin.x
        let y: CGFloat = ((vertex.x-origin.x) * s) + ((vertex.y-origin.y) * c) + origin.y
    
        return CGPoint(x: x, y: y);
    }

}
