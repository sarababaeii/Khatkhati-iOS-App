//
//  DrawingViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/22/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class DrawingViewController: UIViewController {
   
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var canvas: UIImageView!
    @IBOutlet weak var templeCanvas: UIImageView!
    
    @IBOutlet weak var redColorButton: CustomButton!
    @IBOutlet weak var greenColorButton: CustomButton!
    @IBOutlet weak var darkBlueColorButton: CustomButton!
    @IBOutlet weak var yellowColorButton: CustomButton!
    @IBOutlet weak var purpleColorButton: CustomButton!
    @IBOutlet weak var pinkColorButton: CustomButton!
    @IBOutlet weak var brownColorButton: CustomButton!
    @IBOutlet weak var lightBlueColorButton: CustomButton!
    @IBOutlet weak var blackColorButton: CustomButton!
    @IBOutlet weak var grayColorButton: CustomButton!
    @IBOutlet weak var brushButton: CustomButton!
    @IBOutlet weak var eraserButton: CustomButton!
    
    @IBOutlet weak var redColorView: CustomButton!
    @IBOutlet weak var greenColorView: CustomButton!
    @IBOutlet weak var darkBlueColorView: CustomButton!
    @IBOutlet weak var yellowColorView: CustomButton!
    @IBOutlet weak var purpleColorView: CustomButton!
    @IBOutlet weak var pinkColorView: CustomButton!
    @IBOutlet weak var brownColorView: CustomButton!
    @IBOutlet weak var lightBlueColorView: CustomButton!
    @IBOutlet weak var blackColorView: CustomButton!
    @IBOutlet weak var grayColorView: CustomButton!
    
    var brushColorButton: CustomButton?
    var brushColorView: UIView?
    
    var lastPoint = CGPoint.zero
    var brushWidth: CGFloat = 6.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    @IBAction func colorPicked(_ sender: Any) {
        if let brushColorButton = brushColorButton {
            brushColorView?.isHidden = true
            brushColorButton.isHidden = false
        }
        
        brushColorButton = (sender as! CustomButton)
        
        if let siblings = (sender as! UIButton).superview?.subviews {
            for component in siblings {
                if component != sender as! UIView {
                    component.isHidden = false
                    brushColorView = component
                }
            }
        }
        (sender as! UIButton).isHidden = true
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
        context.setStrokeColor((brushColorButton?.color?.cgColor)!)

        context.strokePath()

        templeCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
        templeCanvas.alpha = opacity

        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        swiped = false
        lastPoint = touch.location(in: canvasView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        swiped = true
        let currentPoint = touch.location(in: canvasView)
        drawLine(from: lastPoint, to: currentPoint)

        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
        // draw a single point
            drawLine(from: lastPoint, to: lastPoint)
        }

        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(canvas.frame.size)
        canvas.image?.draw(in: canvasView.bounds, blendMode: .normal, alpha: 1.0)
        templeCanvas?.image?.draw(in: canvasView.bounds, blendMode: .normal, alpha: opacity)
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        templeCanvas.image = nil
    }
    
    func setRedColorAttributes() {
        redColorButton.setCornerRadius(radius: 10)
        redColorButton.setBackgroundColor(color: DrawingColors.red)
        
        redColorView.setCornerRadius(radius: 10)
        redColorView.setBackgroundColor(color: DrawingColors.red)
    }
    
    func setGreenColorAttributes() {
        greenColorButton.setCornerRadius(radius: 10)
        greenColorButton.setBackgroundColor(color: DrawingColors.green)
        
        greenColorView.setCornerRadius(radius: 10)
        greenColorView.setBackgroundColor(color: DrawingColors.green)
    }
    
    func setDarkBlueColorAttributes() {
        darkBlueColorButton.setCornerRadius(radius: 10)
        darkBlueColorButton.setBackgroundColor(color: DrawingColors.darkBlue)
        
        darkBlueColorView.setCornerRadius(radius: 10)
        darkBlueColorView.setBackgroundColor(color: DrawingColors.darkBlue)
    }
    
    func setYellowColorAttributes() {
        yellowColorButton.setCornerRadius(radius: 10)
        yellowColorButton.setBackgroundColor(color: DrawingColors.yellow)
        
        yellowColorView.setCornerRadius(radius: 10)
        yellowColorView.setBackgroundColor(color: DrawingColors.yellow)
    }
    
    func setPurpleColorAttributes() {
        purpleColorButton.setCornerRadius(radius: 10)
        purpleColorButton.setBackgroundColor(color: DrawingColors.purple)
        
        purpleColorView.setCornerRadius(radius: 10)
        purpleColorView.setBackgroundColor(color: DrawingColors.purple)
    }
    
    func setPinkColorAttributes() {
        pinkColorButton.setCornerRadius(radius: 10)
        pinkColorButton.setBackgroundColor(color: DrawingColors.pink)
        
        pinkColorView.setCornerRadius(radius: 10)
        pinkColorView.setBackgroundColor(color: DrawingColors.pink)
    }
    
    func setBrownColorAttributes() {
        brownColorButton.setCornerRadius(radius: 10)
        brownColorButton.setBackgroundColor(color: DrawingColors.brown)
        
        brownColorView.setCornerRadius(radius: 10)
        brownColorView.setBackgroundColor(color: DrawingColors.brown)
    }
    
    func setLightBlueColorAttributes() {
        lightBlueColorButton.setCornerRadius(radius: 10)
        lightBlueColorButton.setBackgroundColor(color: DrawingColors.lightBlue)
        
        lightBlueColorView.setCornerRadius(radius: 10)
        lightBlueColorView.setBackgroundColor(color: DrawingColors.lightBlue)
    }
    
    func setBlackColorAttributes() {
        blackColorButton.setCornerRadius(radius: 10)
        blackColorButton.setBackgroundColor(color: DrawingColors.black)
        
        blackColorView.setCornerRadius(radius: 10)
        blackColorView.setBackgroundColor(color: DrawingColors.black)
    }
    
    func setGrayColorAttributes() {
        grayColorButton.setCornerRadius(radius: 10)
        grayColorButton.setBackgroundColor(color: DrawingColors.gray)
        
        grayColorView.setCornerRadius(radius: 10)
        grayColorView.setBackgroundColor(color: DrawingColors.gray)
    }
    
    func configure() {
        setRedColorAttributes()
        setGreenColorAttributes()
        setDarkBlueColorAttributes()
        setYellowColorAttributes()
        setPurpleColorAttributes()
        setPinkColorAttributes()
        setBrownColorAttributes()
        setLightBlueColorAttributes()
        setBlackColorAttributes()
        setGrayColorAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}
