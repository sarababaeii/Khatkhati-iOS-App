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
    @IBOutlet weak var eraserButton: UIButton!
    @IBOutlet weak var brushButton: UIButton!
    
    var colors = [Color]()

    var isBrushSelected: Bool = false

    var colorsCollectionViewDelegates: ColorsCollectionViewDelegates?
    
    //MARK: Timer Setting
    func setTimer() {
        let timer = TimerSetting(label: timerLabel, time: 60)
        timer.on()
    }
    
    @IBAction func eraserSelected(_ sender: Any) {
        if let cell = Game.sharedInstance.round.drawing?.currentColorCell {
            cell.unSelectColor()
        }
        
        Game.sharedInstance.round.drawing?.brushColor = UIColor.white
        Game.sharedInstance.round.drawing?.brushWidth = 17 //TODO: good?!
    }
    
    @IBAction func brushSelected(_ sender: Any) {
    }
    
    
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
        guard let touch = touches.first, Game.sharedInstance.round.wordChose else {
            return
        }
        
        Game.sharedInstance.round.drawing?.touchesBegan(touch.location(in: canvasView))
        
        SocketIOManager.sharedInstance.sendDrawing(state: "start", point: [(Game.sharedInstance.round.drawing?.lastPoint.x)!, (Game.sharedInstance.round.drawing?.lastPoint.y)!])
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, Game.sharedInstance.round.wordChose else {
            return
        }
        
        Game.sharedInstance.round.drawing?.touchesMoved(touch.location(in: canvasView))
        
        SocketIOManager.sharedInstance.sendDrawing(state: "moving", point: [(Game.sharedInstance.round.drawing?.lastPoint.x)!, (Game.sharedInstance.round.drawing?.lastPoint.y)!])
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard Game.sharedInstance.round.wordChose else {
            return
        }
        
        Game.sharedInstance.round.drawing?.touchesEnded()
        
        SocketIOManager.sharedInstance.sendDrawing(state: "end", point: [(Game.sharedInstance.round.drawing?.lastPoint.x)!, (Game.sharedInstance.round.drawing?.lastPoint.y)!])
    }
    
    //MARK: Initializing
    func initializeBrush() {
//        colorPicked(blackColorButton!)
    }
    
    func initializeVariables() {
        Game.sharedInstance.round.drawing = Drawing(canvasView: self.canvasView, canvas: self.canvas, templeCanvas: self.templeCanvas)
        
        colors = [Colors.red.drawingColor!, Colors.orange.drawingColor!, Colors.yellow.drawingColor!, Colors.purple.drawingColor!, Colors.green.drawingColor!, Colors.darkBlue.drawingColor!, Colors.lightBlue.drawingColor!, Colors.brown.drawingColor!,  Colors.black.drawingColor!, Colors.gray.drawingColor!]
        
        colorsCollectionViewDelegates = ColorsCollectionViewDelegates(colorsCollectionView: colorsCollectionView, colors: colors)
        colorsCollectionView.delegate = colorsCollectionViewDelegates
        colorsCollectionView.dataSource = colorsCollectionViewDelegates
        
        Game.sharedInstance.round.chatTableViewDelegates = MessageTableViewDelegates(chatTableView: chatTableView)
        chatTableView.delegate = Game.sharedInstance.round.chatTableViewDelegates
        chatTableView.dataSource = Game.sharedInstance.round.chatTableViewDelegates
    }
    
    //MARK: UI Handling
    func setWordLabelAttributes() {
        wordLabel.text = Game.sharedInstance.round.word
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
//        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Game.sharedInstance.round.wordChose {
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

//TODO: brush size, initialize brush size
