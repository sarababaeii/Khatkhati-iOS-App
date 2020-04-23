//
//  DrawingViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/22/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class DrawingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
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
    
    var brushSelected: Bool = false
    
    var brushColorButton: CustomButton?
    var brushColorView: UIView?
    
    var drawing: Drawing?
    
    var messages = [Message]()
    
    //MARK: Timer Setting
    func setTimer() {
        let timer = TimerSetting(label: timerLabel, time: 60)
        timer.on()
    }
    
    //MARK: Color picking
    @IBAction func colorPicked(_ sender: Any) {
        unselectedColor()
        
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
        
        if !brushSelected {
            coloring(brushButton!)
        }
        
        drawing?.brushColor = brushColorButton!.color!
    }
    
    @IBAction func coloring(_ sender: Any) {
        showSelected(willShowComponent: brushView!, willHideComponent: brushButton!)
    
        showSelected(willShowComponent: eraserButton!, willHideComponent: eraserView!)

        brushSelected = true
        drawing?.brushWidth = 6.0
        
        if brushColorButton == nil {
            colorPicked(redColorButton!)
        }
    }
    
    @IBAction func erasing(_ sender: Any) {
        showSelected(willShowComponent: eraserView!, willHideComponent: eraserButton!)

        showSelected(willShowComponent: brushButton!, willHideComponent: brushView!)

        brushSelected = false
        unselectedColor()
        
        drawing?.brushWidth = 17.0 //TODO: good?!
        drawing?.brushColor = Colors.white.drawingColor!.topBackground
    }
    
    func unselectedColor() {
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
        guard let touch = touches.first else {
            return
        }
        
        drawing?.touchesBegan(touch.location(in: canvasView))
        
        if let roomID = GameConstants.roomID {
            SocketIOManager.sharedInstance.sendDrawing(roomID: roomID, state: "start", point: [(drawing?.lastPoint.x)!, (drawing?.lastPoint.y)!])
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        drawing?.touchesMoved(touch.location(in: canvasView))
        
        if let roomID = GameConstants.roomID {
            SocketIOManager.sharedInstance.sendDrawing(roomID: roomID, state: "moving", point: [(drawing?.lastPoint.x)!, (drawing?.lastPoint.y)!])
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        drawing?.touchesEnded()
        
        if let roomID = GameConstants.roomID {
            SocketIOManager.sharedInstance.sendDrawing(roomID: roomID, state: "end", point: [(drawing?.lastPoint.x)!, (drawing?.lastPoint.y)!])
        }
    }
    
    //MARK: TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCellID", for: indexPath) as! MessageTableViewCell
        let message = messageDataSource(indexPath: indexPath)
        cell.setCaption(message!)
        return cell
    }
    
    func messageDataSource(indexPath: IndexPath) -> Message? {
        return messages[indexPath.row]
    }
    
    //MARK: Socket Management
    //It would be more clear if it was implemented in SocketIOManager class
    func addSocketHandler() {
        SocketIOManager.sharedInstance.socket?.on("chat_and_guess") {data, ack in
            print("^^^^^RECEIVING MESSAGE^^^^^^")
            
            let temp = data[0] as! [String : Any]
            
            var message: Message
            if (temp["correct"] as! Int) == 1 {
                message = Message(username: temp["username"] as! String, content: "درست حدس زد!")
            } else {
                message = Message(username: temp["username"] as! String, content: temp["text"] as! String)
            }
            
            self.insertMessage(message, at: IndexPath(row: self.messages.count, section: 0))
        }
        
        SocketIOManager.sharedInstance.socket?.on("end_of_the_round") { data, ack in
            SocketIOManager.sharedInstance.endOfRound(data: data[0] as! [String : Any])
            self.showNextPage(identifier: "ScoresViewController")
        }
    }
    
    func insertMessage(_ message: Message?, at indexPath: IndexPath?){
        if let message = message, let indexPath = indexPath{
            chatTableView.beginUpdates()
            
            messages.insert(message, at: indexPath.row)
            chatTableView.insertRows(at: [indexPath], with: .automatic)
        
            chatTableView.endUpdates()
        }
    }
    
    //MARK: Initializing
    func initializeBrush() {
        colorPicked(redColorButton!)
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
    
    func configure() {
        drawing = Drawing(canvasView: self.canvasView, canvas: self.canvas, templeCanvas: self.templeCanvas)
        
//        setTimer()
        
        initializeArrays()
        setColorPaletteAttributes()
        
        initializeBrush()
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        addSocketHandler()
    }
    
    func showChoosingWordViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChoosingWordViewController") as UIViewController
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .coverVertical
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !wordChose {
            showChoosingWordViewController()
            wordChose = true
        }
        
        if wordChose {
            setTimer()
        }
    }
}

//TODO: Timer
