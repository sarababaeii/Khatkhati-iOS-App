//
//  GuessingViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/24/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class GuessingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var canvas: UIImageView!
    @IBOutlet weak var templeCanvas: UIImageView!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var sendButton: CustomButton!
    
    var wordChose = false
    
    var drawing: Drawing?
    
    var messages = [Message]()
    
    //MARK: Timer Setting
    func setTimer() {
        let timer = TimerSetting(label: timerLabel, time: 60)
        timer.on()
    }
    
    //MARK: Socket Management
    //It would be more clear if it was implemented in SocketIOManager class
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
    
    func insertMessage(_ message: Message?, at indexPath: IndexPath?){
        if let message = message, let indexPath = indexPath{
            chatTableView.beginUpdates()
            messages.insert(message, at: indexPath.row)
        
            chatTableView.insertRows(at: [indexPath], with: .automatic)
        
            chatTableView.endUpdates()
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
     
        setChatTextFieldAttributes()
        setSendButtonAttributes()
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        registerForKeyboardNotifications()
        
        addSocketHandler()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !wordChose {
            showNextPage(identifier: "WaitingViewController")
            wordChose = true
        }
        
        if wordChose {
            setTimer()
        }
    }
}
