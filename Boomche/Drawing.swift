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
    
    var brushWidth: CGFloat = 6.0 {
        didSet {
            if Game.sharedInstance.round.painter?.username == Game.sharedInstance.me.username { //TODO: Be more clear
                SocketIOManager.sharedInstance.sendGameSetting(name: "lineWidth", value: String(Float(brushWidth)))
            }
        }
    }
    
    var brushColor: UIColor = Colors.black.drawingColor!.lightBackground {
        didSet {
            if Game.sharedInstance.round.painter?.username == Game.sharedInstance.me.username {
                SocketIOManager.sharedInstance.sendGameSetting(name: "color", value: brushColor.toHexString())
            }
        }
    }
    
    var opacity: CGFloat = 1.0
    var swiped = false
    var lastPoint = CGPoint.zero
    
    init(canvasView: UIView, canvas: UIImageView, templeCanvas: UIImageView) {
        self.canvasView = canvasView
        self.canvas = canvas
        self.templeCanvas = templeCanvas
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        print("YUUUUUUUUHUUUUUUu \(fromPoint) to \(toPoint)")
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
        context.setAllowsAntialiasing(true)
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
        print("MMMMMMOOOOOOVVVVVEEEEE")
        drawLine(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
    }
    
    func touchesEnded() {
        if !swiped {
        // draw a single point
            print("PPPPPPOOOOOOIIIIIINNNNNTTTT")
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

//MMMMMMOOOOOOVVVVVEEEEE
//YUUUUUUUUHUUUUUUu (86.5, 149.5) to (90.0, 173.5)
