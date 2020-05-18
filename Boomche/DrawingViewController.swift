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
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    
    var colors = [Color]()

    var isBrushSelected: Bool = false

    var colorsCollectionViewDelegates: ColorsCollectionViewDelegates?
    
    //MARK: Timer Setting
    func setTimer() {
        let timer = TimerSetting(label: timerLabel, time: 60)
        timer.on()
    }
    
    
//    func selectBrush() {
////        showSelected(willShowComponent: brushView!, willHideComponent: brushButton!)
//
////        showSelected(willShowComponent: eraserButton!, willHideComponent: eraserView!)
//
//        isBrushSelected = true
//        drawing?.brushWidth = 6.0
//        SocketIOManager.sharedInstance.sendGameSetting(name: "lineWidth", value: String(Float(drawing!.brushWidth)))
//
////        if brushColorButton == nil {
////            colorPicked(blackColorButton!)
////        }
//    }
    
//    @IBAction func selectEraser(_ sender: Any) {
////        showSelected(willShowComponent: eraserView!, willHideComponent: eraserButton!)
//
////        showSelected(willShowComponent: brushButton!, willHideComponent: brushView!)
//
//        isBrushSelected = false
//        unselectColor()
//
//        drawing?.brushWidth = 17.0 //TODO: good?!
//        SocketIOManager.sharedInstance.sendGameSetting(name: "lineWidth", value: String(Float(drawing!.brushWidth)))
//        drawing?.brushColor = Colors.white.drawingColor!.lightBackground
//        SocketIOManager.sharedInstance.sendGameSetting(name: "color", value: (Colors.white.drawingColor?.lightBackground.toHexString())!)
//    }
//
    
    func showSelected(willShowComponent: Any, willHideComponent: Any) {
        if let hide = willHideComponent as? UIButton {
            hide.isHidden = true
        } else {
            (willHideComponent as! UIImageView).isHidden = true
        }
        
        if let show = willShowComponent as? UIButton {
            show.isHidden = false
        } else {
            (willShowComponent as! UIImageView).isHidden = false
        }
    }
    
    //MARK: Drawing management
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, Game.sharedInstance.wordChose else {
            return
        }
        
        Game.sharedInstance.drawing?.touchesBegan(touch.location(in: canvasView))
        
        SocketIOManager.sharedInstance.sendDrawing(state: "start", point: [(Game.sharedInstance.drawing?.lastPoint.x)!, (Game.sharedInstance.drawing?.lastPoint.y)!])
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, Game.sharedInstance.wordChose else {
            return
        }
        
        Game.sharedInstance.drawing?.touchesMoved(touch.location(in: canvasView))
        
        SocketIOManager.sharedInstance.sendDrawing(state: "moving", point: [(Game.sharedInstance.drawing?.lastPoint.x)!, (Game.sharedInstance.drawing?.lastPoint.y)!])
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard Game.sharedInstance.wordChose else {
            return
        }
        
        Game.sharedInstance.drawing?.touchesEnded()
        
        SocketIOManager.sharedInstance.sendDrawing(state: "end", point: [(Game.sharedInstance.drawing?.lastPoint.x)!, (Game.sharedInstance.drawing?.lastPoint.y)!])
    }
    
    //MARK: Initializing
    func initializeBrush() {
//        colorPicked(blackColorButton!)
    }
    
    func initializeVariables() {
        Game.sharedInstance.drawing = Drawing(canvasView: self.canvasView, canvas: self.canvas, templeCanvas: self.templeCanvas)
        
        colors = [Colors.red.drawingColor!, Colors.orange.drawingColor!, Colors.yellow.drawingColor!, Colors.purple.drawingColor!, Colors.green.drawingColor!, Colors.darkBlue.drawingColor!, Colors.lightBlue.drawingColor!, Colors.brown.drawingColor!,  Colors.black.drawingColor!, Colors.gray.drawingColor!]
        
        colorsCollectionViewDelegates = ColorsCollectionViewDelegates(colorsCollectionView: colorsCollectionView, colors: colors)
        colorsCollectionView.delegate = colorsCollectionViewDelegates
        colorsCollectionView.dataSource = colorsCollectionViewDelegates
        
        Game.sharedInstance.chatTableViewDelegates = MessageTableViewDelegates(chatTableView: chatTableView)
        chatTableView.delegate = Game.sharedInstance.chatTableViewDelegates
        chatTableView.dataSource = Game.sharedInstance.chatTableViewDelegates
    }
    
    //MARK: UI Handling
    func setWordLabelAttributes() {
        wordLabel.text = Game.sharedInstance.word
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
//        configure()
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
        }
    }
}
