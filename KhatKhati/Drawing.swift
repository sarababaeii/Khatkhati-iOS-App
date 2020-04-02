//
//  Drawing.swift
//  KhatKhati
//
//  Created by Sara Babaei on 4/2/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class Drawing {
    var canvasView: UIView
    var canvas: UIImageView
    var templeCanvas: UIImageView
    
    var lastPoint = CGPoint.zero
    var brushWidth: CGFloat = 6.0
    var brushColor: UIColor = Colors.red.drawingColor!.topBackground
    
    var opacity: CGFloat = 1.0
    var swiped = false
    
    init(canvasView: UIView, canvas: UIImageView, templeCanvas: UIImageView) {
        self.canvasView = canvasView
        self.canvas = canvas
        self.templeCanvas = templeCanvas
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(canvasView.frame.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        templeCanvas.image?.draw(in: canvasView.bounds)

        context.move(to: fromPoint)
        context.addLine(to: toPoint)

        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(brushColor.cgColor)
        context.strokePath()

        templeCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
        templeCanvas.alpha = opacity

        UIGraphicsEndImageContext()
    }
    
    func touchesBegan(_ touch: CGPoint) {
        swiped = false
        lastPoint = touch
    }
    
    func touchesMoved(_ touch: CGPoint) {
        swiped = true
        let currentPoint = touch
        drawLine(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
    }
    
    func touchesEnded() {
        if !swiped {
        // draw a single point
            drawLine(from: lastPoint, to: lastPoint)
            //send to server!!
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(canvas.frame.size)
        canvas.image?.draw(in: canvasView.bounds, blendMode: .normal, alpha: 1.0)
        templeCanvas.image?.draw(in: canvasView.bounds, blendMode: .normal, alpha: opacity)
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        templeCanvas.image = nil
    }
}
