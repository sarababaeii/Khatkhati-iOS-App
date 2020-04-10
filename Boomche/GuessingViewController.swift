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
    
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var canvas: UIImageView!
    @IBOutlet weak var templeCanvas: UIImageView!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var sendButton: CustomButton!
    
    var drawing: Drawing?
    
    //MARK: Timer Setting
    func setTimer() {
        let timer = TimerSetting(label: timerLabel, time: 60)
        timer.on()
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if let message = fetchInput() {
            SocketIOManager.sharedInstance.sendMessage(message: message)
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
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
//        adjustLayoutForKeyboard(targetHight: 0)
    }
    
    func adjustLayoutForKeyboard(targetHight: CGFloat){
//        if self.view.frame.origin.y == 0 {
            messageView.frame.origin.y -= targetHight
//        }
//        messageView.bottom = targetHight
    }
    
    //MARK: Socket Management
    //It would be more clear if it was implemented in SocketIOManager class
    func addSocketHandler() {
        SocketIOManager.sharedInstance.socket?.on("conversation_private") { data, ack in
            var temp = data[0] as! [String : Any]
            temp = temp["data"] as! [String : Any]
            
            if let roomID = GameConstants.roomID {
                if roomID == temp["room"] as! String {
                    self.showDrawing(state: temp["state"] as! String, point: temp["point"] as! [CGFloat])
                }
            }
        }
    }
    
    func showDrawing(state: String, point: [CGFloat]) {
        switch state {
        case "start":
            drawing?.touchesBegan(CGPoint(x: point[0], y: point[1]))
        case "moving":
            drawing?.touchesMoved(CGPoint(x: point[0], y: point[1]))
        case "end":
            drawing?.touchesEnded()
        default:
            print("Error in receiving draw")
        }
    }
    
    //MARK: UI Handling
    func setChatTextFieldAttributes(){
        chatTextField.layer.cornerRadius = 22
    }
    
    func setSendButtonAttributes(){
        sendButton.setCornerRadius(radius: 18)
        sendButton.setBackgroundColor(color: Colors.blue.componentColor!)
    }
    
    func configure() {
        drawing = Drawing(canvasView: self.canvasView, canvas: self.canvas, templeCanvas: self.templeCanvas)
        
        setTimer()
        
        setChatTextFieldAttributes()
        setSendButtonAttributes()
        
        registerForKeyboardNotifications()
        
        addSocketHandler()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}
