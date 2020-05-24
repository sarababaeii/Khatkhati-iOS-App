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
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    //MARK: Timer Setting
    func setTimer() {
        var time = 60
        if Game.sharedInstance.joinedMiddle {
            time = Game.sharedInstance.time!
        }
        timerLabel.text = String(time).convertEnglishNumToPersianNum()
        let timer = TimerSetting(label: timerLabel, time: time)
        timer.on()
    }
    
    //MARK: Socket Management For Drawing
    func addSocketHandler() {
        SocketIOManager.sharedInstance.socket?.on("conversation_private") { data, ack in
            var temp = data[0] as! [String : Any]
            temp = temp["data"] as! [String : Any]
            
            if let roomID = Game.sharedInstance.roomID {
                if roomID == temp["room"] as! String {
                    self.showDrawing(state: temp["state"] as! String, point: temp["point"] as! [CGFloat])
                }
            }
        }
    }
    
    func showDrawing(state: String, point: [CGFloat]) {
        switch state {
        case "start":
            Game.sharedInstance.round.drawing?.touchesBegan(CGPoint(x: point[0], y: point[1]))
        case "moving":
            Game.sharedInstance.round.drawing?.touchesMoved(CGPoint(x: point[0], y: point[1]))
        case "end":
            Game.sharedInstance.round.drawing?.touchesEnded()
        default:
            print("Error in receiving draw")
        }
    }
    
    //MARK: Sending Message
    @IBAction func sendMessage(_ sender: Any) {
        if let message = fetchInput() {
            SocketIOManager.sharedInstance.sendMessage(message: message)
            chatTextField.text = ""
            chatTextField.resignFirstResponder()
        }
    }
    
    func fetchInput() -> String? {
        if let caption = chatTextField.text?.trimmingCharacters(in: .whitespaces) {
            return caption.count > 0 ? caption : nil
        }
        return nil
    }
    
    //MARK: Keyboard Management
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatTextField.resignFirstResponder()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
//                self.view.frame.origin.y += keyboardSize.height
                self.view.frame.origin.y = 0
            }
        }
//        adjustLayoutForKeyboard(targetHight: 0)
    }
    
    func adjustLayoutForKeyboard(targetHight: CGFloat){
//        if self.view.frame.origin.y == 0 {
            messageView.frame.origin.y -= targetHight
//        }
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
        
        addSocketHandler()
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
        } else {
            WaitingViewController.parentViewController = self
            showNextPage(identifier: "WaitingViewController")
        }
    }
}
