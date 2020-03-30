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
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var sendButton: CustomButton!
    
    func setTimer() {
        let timer = TimerSetting(label: timerLabel)
        timer.on()
    }
    
    //MARK: Keyboard management
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
        adjustLayoutForKeyboard(targetHight: 0)
    }
    
    func adjustLayoutForKeyboard(targetHight: CGFloat){
//        if self.view.frame.origin.y == 0 {
            messageView.frame.origin.y -= targetHight
//        }
//        messageView.bottom = targetHight
    }
    
    func setChatTextFieldAttributes(){
        chatTextField.layer.cornerRadius = 22
    }
    
    func setSendButtonAttributes(){
        sendButton.setCornerRadius(radius: 18)
        sendButton.setBackgroundColor(color: Colors.blue.componentColor!)
    }
    
    func configure() {
        setTimer()
        
        setChatTextFieldAttributes()
        setSendButtonAttributes()
        
        registerForKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}
