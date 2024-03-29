//
//  GuessingViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/24/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class GuessingViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var canvas: UIImageView!
    @IBOutlet weak var templeCanvas: UIImageView!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
    
    //MARK: Timer Setting
    func setTimer() {
        var time = 60
        if Game.sharedInstance.joinedState == 1 {
            time = Game.sharedInstance.time!
        }
        timerLabel.text = "۰:" + String(time).convertEnglishNumToPersianNum()
        _ = TimerSetting(label: timerLabel, time: time, from: self)
    }
    
    //MARK: Previous Drawing For Random Game
    func showPreDrawing() {
        guard let paint = Game.sharedInstance.round.paint else {
            return
        }
        for stroke in paint {
            drawStroke(points: stroke)
        }
    }
    
    func drawStroke(points: [[CGFloat]]) {
        //brush size and color
        Game.sharedInstance.round.drawing?.touchesBegan(CGPoint(x: points[0][0], y: points[0][1]))
        for i in 0 ..< points.count {
            Game.sharedInstance.round.drawing?.touchesMoved(CGPoint(x: points[i][0], y: points[i][1]))
        }
        Game.sharedInstance.round.drawing?.touchesEnded()
    }
    
    //MARK: Sending Message
    @IBAction func sendMessage(_ sender: Any) {
        if let message = chatTextField.fetchInput() {
            SocketIOManager.sharedInstance.sendMessage(message: message)
            chatTextField.text = ""
        }
        chatTextField.resignFirstResponder()
    }
    
    //MARK: Keyboard Management
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatTextField.resignFirstResponder()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowOrChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowOrChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShowOrChange(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        messageViewBottomConstraint.constant = -keyboardSize.height + bottomView.frame.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        messageViewBottomConstraint.constant = 0
    }
    
    //MARK: Initializing
    func initializeVariables() {
        Game.sharedInstance.round.drawing = Drawing(canvasView: self.canvasView, canvas: self.canvas, templeCanvas: self.templeCanvas)
        Game.sharedInstance.round.chatTableViewDelegates = MessageTableViewDelegates(chatTableView: chatTableView)
        
        chatTableView.delegate = Game.sharedInstance.round.chatTableViewDelegates
        chatTableView.dataSource = Game.sharedInstance.round.chatTableViewDelegates
    }
    
    func setWordLabel() {
        guard let word = Game.sharedInstance.round.word else {
            return
        }
        var s = ""
        for _ in word {
            s += "-"
        }
        wordLabel.text = s
    }
    
    func configure() {
        registerForKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Game.sharedInstance.round.wordChose {
            setTimer()
            initializeVariables()
            setWordLabel()
            showPreDrawing()
        } else {
            WaitingViewController.parentViewController = self
            showNextPage(identifier: "WaitingViewController")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setGradientSizes()
    }
}
