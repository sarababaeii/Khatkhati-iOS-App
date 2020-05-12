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
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var canvas: UIImageView!
    @IBOutlet weak var templeCanvas: UIImageView!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    //MARK: ColorPalette:
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
    @IBOutlet weak var brushView: UIImageView!
    @IBOutlet weak var eraserView: UIImageView!
    
    var wordChose = false
    
    var colorButtons = [CustomButton]()
    var colorViews = [CustomButton]()
    var colors = [Color]()
   
    var drawing: Drawing?
    var isBrushSelected: Bool = false
    
    var brushColorButton: CustomButton?
    var brushColorView: UIView?
    
    static var chatTableViewDelegates: MessageTableViewDelegates?
    
    //MARK: Timer Setting
    func setTimer() {
        let timer = TimerSetting(label: timerLabel, time: 60)
        timer.on()
    }
    
    //MARK: Color picking
    @IBAction func colorPicked(_ sender: Any) {
        unselectColor()
        
        brushColorButton = (sender as! CustomButton)
        
        if let siblings = (sender as! UIButton).superview?.subviews {
            for component in siblings {
                if component != sender as! UIView {
                    showSelected(willShowComponent: component, willHideComponent: sender)
                    brushColorView = component
                }
            }
        }
        
        if !isBrushSelected {
            selectBrush(brushButton!)
        }
        
        drawing?.brushColor = brushColorButton!.color!
        SocketIOManager.sharedInstance.sendGameSetting(name: "color", value: (drawing?.brushColor.toHexString())!)
    }
    
    @IBAction func selectBrush(_ sender: Any) {
        showSelected(willShowComponent: brushView!, willHideComponent: brushButton!)
    
        showSelected(willShowComponent: eraserButton!, willHideComponent: eraserView!)

        isBrushSelected = true
        drawing?.brushWidth = 6.0
        SocketIOManager.sharedInstance.sendGameSetting(name: "lineWidth", value: String(Float(drawing!.brushWidth)))
        
        if brushColorButton == nil {
            colorPicked(blackColorButton!)
        }
    }
    
    @IBAction func selectEraser(_ sender: Any) {
        showSelected(willShowComponent: eraserView!, willHideComponent: eraserButton!)

        showSelected(willShowComponent: brushButton!, willHideComponent: brushView!)

        isBrushSelected = false
        unselectColor()
        
        drawing?.brushWidth = 17.0 //TODO: good?!
        SocketIOManager.sharedInstance.sendGameSetting(name: "lineWidth", value: String(Float(drawing!.brushWidth)))
        drawing?.brushColor = Colors.white.drawingColor!.lightBackground
        SocketIOManager.sharedInstance.sendGameSetting(name: "color", value: (Colors.white.drawingColor?.lightBackground.toHexString())!)
    }
    
    func unselectColor() {
        if let brushColorButton = brushColorButton {
            showSelected(willShowComponent: brushColorButton, willHideComponent: brushColorView!)
        }
        
        brushColorView = nil
        brushColorButton = nil
    }
    
    func showSelected(willShowComponent: Any, willHideComponent: Any) {
        if let hide = willHideComponent as? CustomButton {
            hide.isHidden = true
        } else {
            (willHideComponent as! UIImageView).isHidden = true
        }
        
        if let show = willShowComponent as? CustomButton {
            show.isHidden = false
        } else {
            (willShowComponent as! UIImageView).isHidden = false
        }
    }
    
    //MARK: Drawing management
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, wordChose else {
            return
        }
        
        drawing?.touchesBegan(touch.location(in: canvasView))
        
        SocketIOManager.sharedInstance.sendDrawing(state: "start", point: [(drawing?.lastPoint.x)!, (drawing?.lastPoint.y)!])
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, wordChose else {
            return
        }
        
        drawing?.touchesMoved(touch.location(in: canvasView))
        
        SocketIOManager.sharedInstance.sendDrawing(state: "moving", point: [(drawing?.lastPoint.x)!, (drawing?.lastPoint.y)!])
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard wordChose else {
            return
        }
        
        drawing?.touchesEnded()
        
        SocketIOManager.sharedInstance.sendDrawing(state: "end", point: [(drawing?.lastPoint.x)!, (drawing?.lastPoint.y)!])
    }
    
    //MARK: Initializing
    func initializeBrush() {
        colorPicked(blackColorButton!)
    }
    
    func initializeVariables() {
        drawing = Drawing(canvasView: self.canvasView, canvas: self.canvas, templeCanvas: self.templeCanvas)
        DrawingViewController.chatTableViewDelegates = MessageTableViewDelegates(chatTableView: chatTableView)
        
        chatTableView.delegate = DrawingViewController.chatTableViewDelegates
        chatTableView.dataSource = DrawingViewController.chatTableViewDelegates
    }
    
    func clearVariables() { //drawing?!
        DrawingViewController.chatTableViewDelegates = nil
    }
    
    //MARK: UI Handling
    func initializeArrays() {
        colorButtons = [redColorButton, greenColorButton, darkBlueColorButton, yellowColorButton, purpleColorButton, pinkColorButton, brownColorButton, lightBlueColorButton, blackColorButton, grayColorButton]
        
         colorViews = [redColorView, greenColorView, darkBlueColorView, yellowColorView, purpleColorView, pinkColorView, brownColorView, lightBlueColorView, blackColorView, grayColorView]
         
         colors = [Colors.red.drawingColor!, Colors.green.drawingColor!, Colors.darkBlue.drawingColor!, Colors.yellow.drawingColor!, Colors.purple.drawingColor!, Colors.pink.drawingColor!, Colors.brown.drawingColor!, Colors.lightBlue.drawingColor!, Colors.black.drawingColor!, Colors.gray.drawingColor!]
    }
    
    func setColorPaletteAttributes() {
        for i in 0..<colors.count {
            colorButtons[i].setCornerRadius(radius: 10)
            colorButtons[i].setBackgroundColor(color: colors[i])
            
            colorViews[i].setCornerRadius(radius: 10)
            colorViews[i].setBackgroundColor(color: colors[i])
        }
    }
    
    func setWordLabelAttributes() {
        wordLabel.text = Game.sharedInstance.word
    }
    
    func configure() {
        initializeArrays()
        setColorPaletteAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Game.sharedInstance.wordChose {
            setTimer()
            initializeVariables()
            setWordLabelAttributes()
            initializeBrush()
        } else{
            ChoosingWordViewController.parentViewController = self
            showNextPage(identifier: "ChoosingWordViewController")
            wordChose = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        clearVariables()
    }
}
