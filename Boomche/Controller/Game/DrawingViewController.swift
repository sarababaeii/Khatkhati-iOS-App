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
    
    //MARK: Color Palette
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var eraserButton: UIButton!
    @IBOutlet weak var brushButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    
    //MARK: Thickness
    @IBOutlet weak var brushSizeView: UIView!
    @IBOutlet weak var brushSizeButton1: UIButton!
    
    @IBOutlet weak var eraserSizeView: UIView!
    @IBOutlet weak var eraserSizeButton2: UIButton!
    
    var colors = [Color]()
    var colorsCollectionViewDelegates: ColorsCollectionViewDelegates?
    
    var selectedTool: UIButton?
    var selectedBrushSize: UIButton?
    var selectedEraserSize: UIButton?
    
    let brushSizes = [4, 6, 12, 24]
    let toolImages = [["SelectedEraser", "Eraser"], ["SelectedPaintBrush", "PaintBrush"], ["SelectedTrash", "Trash"]]
    
    //MARK: Timer Setting
    func setTimer() {
        _ = TimerSetting(label: timerLabel, time: 60, from: self)
    }
    
    //MARK: Selectin Tool
    @IBAction func colorPicked(_ sender: Any) {
        selectBrush()
    }
    
    func selectBrush() {
        if selectedTool == brushButton {
            return
        }
        unselectPreviousTool(by: brushButton)
    }
    
    @IBAction func brushSelected(_ sender: Any) {
        if selectedTool == sender as? UIButton {
            showThicknessView(view: brushSizeView)
        } else {
            selectBrush()
            colorsCollectionViewDelegates?.blackCell?.selectColor()
        }
    }
    
    @IBAction func eraserSelected(_ sender: Any) {
        if selectedTool == sender as? UIButton {
            showThicknessView(view: eraserSizeView)
        } else {
            Game.sharedInstance.round.drawing?.brushColor = UIColor.white
            unselectPreviousTool(by: eraserButton)
        }
    }
    
    func showThicknessView(view: UIView) {
        view.isHidden = !view.isHidden
    }
    
    //MARK: Selecting Thickness
    @IBAction func changeThickness(_ sender: Any) {
        let tag = (sender as? UIButton)?.tag
        if tag == 0 || tag == 1 || tag == 2 || tag == 3 {
            selectThickness(button: sender as! UIButton)
        }
        (sender as? UIButton)?.superview?.isHidden = true
    }
    
    func selectThickness(button: UIButton) {
        if button.superview?.restorationIdentifier == "BrushSizeView"{
            selectBrushSize(button: button)
        } else if button.superview?.restorationIdentifier == "EraserSizeView"{
            selectEraserSize(button: button)
        }
        button.backgroundColor = Colors.blue.componentColor?.lightBackground
    }
    
    func selectBrushSize(button: UIButton) {
        if let selectedButton = selectedBrushSize {
            unselectThickness(button: selectedButton)
        }
        selectedBrushSize = button
        Game.sharedInstance.round.drawing?.brushWidth = CGFloat(brushSizes[button.tag])
    }
    
    func selectEraserSize(button: UIButton) {
        if let selectedButton = selectedEraserSize {
            unselectThickness(button: selectedButton)
        }
        selectedEraserSize = button
        //drawing
    }
    
    func unselectThickness(button: UIButton) {
        button.backgroundColor = Colors.dusk.componentColor?.lightBackground
    }
    
    @IBAction func trashSelected(_ sender: Any) {
        if selectedTool == sender as? UIButton {
            return
        }
        canvas.image = nil
        unselectPreviousTool(by: trashButton)
    }
    
    func unselectPreviousTool(by button: UIButton) {
        if let tool = selectedTool {
            changeImage(of: tool, to: toolImages[tool.tag][1])
            if selectedTool == brushButton {
                Game.sharedInstance.round.drawing?.currentColorCell?.unSelectColor()
            }
        }
        brushSizeView.isHidden = true
        eraserSizeView.isHidden = true
        
        selectCurrentTool(button: button)
    }
    
    func selectCurrentTool(button: UIButton) {
        selectedTool = button
        changeImage(of: button, to: toolImages[button.tag][0])
    }
    
    func changeImage(of button: UIButton, to imageName: String) {
        button.setImage(UIImage(named: imageName), for: .normal)
    }
    
    //MARK: Drawing Management
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, Game.sharedInstance.round.wordChose, selectedTool != trashButton else {
            return
        }
        Game.sharedInstance.round.drawing?.touchesBegan(touch.location(in: canvasView))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, Game.sharedInstance.round.wordChose, selectedTool != trashButton else {
            return
        }
        Game.sharedInstance.round.drawing?.touchesMoved(touch.location(in: canvasView))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard Game.sharedInstance.round.wordChose, selectedTool != trashButton else {
            return
        }
        Game.sharedInstance.round.drawing?.touchesEnded()
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
        selectThickness(button: brushSizeButton1)
        selectThickness(button: eraserSizeButton2)
    }
    
    func initializeVariables() {
        Game.sharedInstance.round.drawing = Drawing(canvasView: self.canvasView, canvas: self.canvas, templeCanvas: self.templeCanvas)
 
        Game.sharedInstance.round.chatTableViewDelegates = MessageTableViewDelegates(chatTableView: chatTableView)
        Game.sharedInstance.round.drawing?.currentColorCell = colorsCollectionViewDelegates?.blackCell
      
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
        } else{
            ChoosingWordViewController.parentViewController = self
            showNextPage(identifier: "ChoosingWordViewController")
        }
    }
}
