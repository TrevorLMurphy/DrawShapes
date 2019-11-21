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
        return CGFloat(self) * CGFloat(Double.pi) / 180.0
    }
}

class Shapes: UIView {
    var whichShape: String = ""
    var sideNum: Int = 0
    let radius: CGFloat = 90
    var timesDrawn: Int = 0
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        let origin = CGPoint(x: width/2, y: height/2)
        
        context!.setLineWidth(1)
        
        switch whichShape {
        case "Circle":
            context!.setStrokeColor(UIColor.red.cgColor)
        case "Triangle":
            context!.setStrokeColor(UIColor.orange.cgColor)
            sideNum = 3
        case "Square":
            context!.setStrokeColor(UIColor.purple.cgColor)
            sideNum = 4
        case "Pentagon":
            context!.setStrokeColor(UIColor.blue.cgColor)
            sideNum = 5
        default:
            context!.setStrokeColor(UIColor.black.cgColor)
        }
        
        drawShapes(
            context: context!,
            origin: origin,
            nSides: sideNum,
            nTimes: timesDrawn
        )
    }
    
    func drawShapes(context: CGContext, origin: CGPoint, nSides: Int, nTimes: Int) {
        var centerOfShape = CGPoint(x: origin.x, y: origin.y - radius)
        let degreesToRotate: CGFloat = CGFloat(
            Double(360) / Double(timesDrawn)
        ).degreesToRadians
        
        for _ in 0 ..< nTimes {
            if nSides == 0 {
                context.addArc(
                    center: centerOfShape,
                    radius: radius,
                    startAngle: 0.0,
                    endAngle: CGFloat(Double.pi * 2.0),
                    clockwise: true
                )
            } else  {
                let shapeDegrees: CGFloat = CGFloat(360 / nSides).degreesToRadians
                var shapeVertex: CGPoint = origin; // The point that is rotated to build polygon.
                context.move(to: shapeVertex)
                for _ in 0 ..< nSides {
                    let nextShapeVertex: CGPoint = rotatePoint(
                        origin: centerOfShape,
                        vertex: shapeVertex,
                        radians: shapeDegrees
                    )
                    context.addLine(to: nextShapeVertex)
                    shapeVertex = nextShapeVertex;
                    context.move(to: shapeVertex)
                }
                
            }
            context.strokePath()
            centerOfShape = rotatePoint(
                origin: origin,
                vertex: centerOfShape,
                radians: degreesToRotate
            )
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
