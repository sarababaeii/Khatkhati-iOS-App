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
    
    //MARK: Color Palette:
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var eraserButton: UIButton!
    @IBOutlet weak var brushButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    
    //MARK: Brush Thickness
    @IBOutlet weak var brushSizeView: UIView!
    @IBOutlet weak var brushSizeButton0: UIButton!
    @IBOutlet weak var brushSizeButton1: UIButton!
    @IBOutlet weak var brushSizeButton2: UIButton!
    @IBOutlet weak var brushSizeButton3: UIButton!
    
    var colors = [Color]()
    var colorsCollectionViewDelegates: ColorsCollectionViewDelegates?
    
    var selectedTool: UIButton?
    var selectedBrushSize: UIButton?
    
    let brushSizes = [4, 6, 12, 24]
    
//    var drawing: Drawing?
    
    //MARK: Timer Setting
    func setTimer() {
        let timer = TimerSetting(label: timerLabel, time: 60)
        timer.on()
    }
    
    @IBAction func colorPicked(_ sender: Any) {
        selectBrush()
    }
    
    @IBAction func eraserSelected(_ sender: Any) {
        if selectedTool == sender as? UIButton {
            return
        }
        
        Game.sharedInstance.round.drawing?.brushColor = UIColor.white
//        drawing?.brushColor = UIColor.white
        
        eraserButton.setImage(UIImage(named: "SelectedEraser"), for: .normal)
        unselectTool(by: eraserButton)
    }
    
    @IBAction func brushSelected(_ sender: Any) {
//        if selectedTool != sender as? UIButton {
//            brushButton.setImage(UIImage(named: "SelectedPaintBrush"), for: .normal)
////            colorsCollectionViewDelegates?.blackCell?.selectColor()
//            unselectTool(by: brushButton)
//        }
        
        brushSizeView.isHidden = false
    }
    
    func selectBrush() {
        if selectedTool == brushButton {
            return
        }
        
        brushButton.setImage(UIImage(named: "SelectedPaintBrush"), for: .normal)
        unselectTool(by: brushButton)
    }
    
    @IBAction func trashSelected(_ sender: Any) {
        if selectedTool == sender as? UIButton {
            return
        }
        canvas.image = nil
        Game.sharedInstance.round.drawing?.brushColor = UIColor.white
        trashButton.setImage(UIImage(named: "SelectedTrash"), for: .normal)
        unselectTool(by: trashButton)
    }
    
    //unselect previous
    @IBAction func changeBrushSize(_ sender: Any) {
        let tag = (sender as? UIButton)?.tag
        if tag == 0 || tag == 1 || tag == 2 || tag == 3 {
            selectBrushSize(button: sender as! UIButton)
        }
        brushSizeView.isHidden = true
    }
    
    func selectBrushSize(button: UIButton) {
        selectedBrushSize?.backgroundColor = Colors.dusk.componentColor?.lightBackground
        Game.sharedInstance.round.drawing?.brushWidth = CGFloat(brushSizes[button.tag])
//        drawing?.brushWidth = CGFloat(brushSizes[button.tag])
        button.backgroundColor = Colors.blue.componentColor?.lightBackground
        selectedBrushSize = button
    }
    
    func unselectTool(by button: UIButton) {
        switch selectedTool {
        case eraserButton:
            eraserButton.setImage(UIImage(named: "Eraser"), for: .normal)
        case brushButton:
            Game.sharedInstance.round.drawing?.currentColorCell?.unSelectColor()
//            drawing?.currentColorCell?.unSelectColor()
            brushButton.setImage(UIImage(named: "PaintBrush"), for: .normal)
        case trashButton:
            trashButton.setImage(UIImage(named: "Trash"), for: .normal)
        default:
            eraserButton.setImage(UIImage(named: "Eraser"), for: .normal)
        }
        
        selectedTool = button
    }
    
    //MARK: Drawing Management
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, Game.sharedInstance.round.wordChose else {
            return
        }
        
        Game.sharedInstance.round.drawing?.touchesBegan(touch.location(in: canvasView))
//        drawing?.touchesBegan(touch.location(in: canvasView))
        
        SocketIOManager.sharedInstance.sendDrawing(state: "start", point: [(Game.sharedInstance.round.drawing?.lastPoint.x)!, (Game.sharedInstance.round.drawing?.lastPoint.y)!])
//        SocketIOManager.sharedInstance.sendDrawing(state: "start", point: [(drawing?.lastPoint.x)!, (drawing?.lastPoint.y)!])
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, Game.sharedInstance.round.wordChose else {
            return
        }
        
        Game.sharedInstance.round.drawing?.touchesMoved(touch.location(in: canvasView))
//        drawing?.touchesMoved(touch.location(in: canvasView))
        
        SocketIOManager.sharedInstance.sendDrawing(state: "moving", point: [(Game.sharedInstance.round.drawing?.lastPoint.x)!, (Game.sharedInstance.round.drawing?.lastPoint.y)!])
//        SocketIOManager.sharedInstance.sendDrawing(state: "moving", point: [(drawing?.lastPoint.x)!, (drawing?.lastPoint.y)!])
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard Game.sharedInstance.round.wordChose else {
            return
        }
        
        Game.sharedInstance.round.drawing?.touchesEnded()
//        drawing?.touchesEnded()
        
        SocketIOManager.sharedInstance.sendDrawing(state: "end", point: [(Game.sharedInstance.round.drawing?.lastPoint.x)!, (Game.sharedInstance.round.drawing?.lastPoint.y)!])
//        SocketIOManager.sharedInstance.sendDrawing(state: "end", point: [(drawing?.lastPoint.x)!, (drawing?.lastPoint.y)!])
    }
    
    //MARK: Initializing
    func initializeColorPalette() {
        colors = [Colors.red.drawingColor!, Colors.orange.drawingColor!, Colors.yellow.drawingColor!, Colors.purple.drawingColor!, Colors.green.drawingColor!, Colors.darkBlue.drawingColor!, Colors.lightBlue.drawingColor!, Colors.brown.drawingColor!,  Colors.black.drawingColor!, Colors.gray.drawingColor!]
        
        colorsCollectionViewDelegates = ColorsCollectionViewDelegates(colorsCollectionView: colorsCollectionView, colors: colors)
        colorsCollectionView.delegate = colorsCollectionViewDelegates
        colorsCollectionView.dataSource = colorsCollectionViewDelegates
    }
    
    func initializeBrush() {
        selectedTool = brushButton
        selectBrushSize(button: brushSizeButton1)
    }
    
    func initializeVariables() {
        Game.sharedInstance.round.drawing = Drawing(canvasView: self.canvasView, canvas: self.canvas, templeCanvas: self.templeCanvas)
//        drawing = Drawing(canvasView: self.canvasView, canvas: self.canvas, templeCanvas: self.templeCanvas)
        
        Game.sharedInstance.round.chatTableViewDelegates = MessageTableViewDelegates(chatTableView: chatTableView)
        Game.sharedInstance.round.drawing?.currentColorCell = colorsCollectionViewDelegates?.blackCell
//        drawing?.currentColorCell = colorsCollectionViewDelegates?.blackCell
        
        chatTableView.delegate = Game.sharedInstance.round.chatTableViewDelegates
        chatTableView.dataSource = Game.sharedInstance.round.chatTableViewDelegates
    }
    
    //MARK: UI Handling
    func setWordLabelAttributes() {
        wordLabel.text = Game.sharedInstance.round.word
    }
    
    func firstConfigure() {
        initializeColorPalette()
        initializeBrush()
    }
    
    func secondConfigure() {
        setTimer()
        initializeVariables()
        setWordLabelAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        firstConfigure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Game.sharedInstance.round.wordChose {
            secondConfigure()
//            initializeBrush()
        } else{
            ChoosingWordViewController.parentViewController = self
            showNextPage(identifier: "ChoosingWordViewController")
        }
    }
}
