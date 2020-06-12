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
    
    var currentColorCell: ColorCollectionViewCell? {
        didSet {
            brushColor = (currentColorCell?.color.lightBackground)!
        }
    }
    
    var eraserWidth: CGFloat = 12.0 {
        didSet {
            if brushColor == UIColor.white {
                thickness = eraserWidth
            }
        }
    }
    
    var brushWidth: CGFloat = 6.0 {
        didSet {
            if brushColor != UIColor.white {
                thickness = brushWidth
            }
        }
    }
    
    var thickness: CGFloat = 6.0 {
        didSet {
            sendSetting(variable: "lineWidth", value: String(Float(thickness)))
        }
    }
    
    var brushColor: UIColor = Colors.black.drawingColor!.lightBackground {
        willSet {
            if brushColor == UIColor.white {
                thickness = brushWidth
            }
        }
        didSet {
            sendSetting(variable: "color", value: brushColor.toHexString())
            
            if brushColor == UIColor.white {
                thickness = eraserWidth
            }
        }
    }
    
    var opacity: CGFloat = 1.0
    var swiped = false
    var lastPoint = CGPoint.zero
    
    //MARK: Initializer
    init(canvasView: UIView, canvas: UIImageView, templeCanvas: UIImageView) {
        self.canvasView = canvasView
        self.canvas = canvas
        self.templeCanvas = templeCanvas
    }
    
    //MARK: Drawing
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
        context.setLineWidth(thickness)
        context.setStrokeColor(brushColor.cgColor)
        context.setAllowsAntialiasing(true)
        context.strokePath()

        templeCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
        templeCanvas.alpha = opacity

        UIGraphicsEndImageContext()
    }
    
    func touchesBegan(_ touch: CGPoint) {
        swiped = false
        lastPoint = touch
        
        sendDrawing(state: "start")
    }
    
    func touchesMoved(_ touch: CGPoint) {
        swiped = true
        let currentPoint = touch
        drawLine(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
        
        sendDrawing(state: "moving")
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
        
        sendDrawing(state: "end")
    }
    
    //MARK: Server Handling
    func sendSetting(variable: String, value: String) {
        if Game.sharedInstance.me.isPainter {
            SocketIOManager.sharedInstance.sendGameSetting(name: variable, value: value)
        }
    }
    
    func sendDrawing(state: String) {
        if Game.sharedInstance.me.isPainter {
            SocketIOManager.sharedInstance.sendDrawing(state: state, point: [lastPoint.x, lastPoint.y])
        }
    }
}
