//
//  JoinGameViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/20/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class JoinGameViewController: UIViewController, UITextFieldDelegate {
    //MARK: Defenitions
    @IBOutlet weak var randomGameButton: CustomButton!
    @IBOutlet weak var lobbyCodeTextField: UITextField!
    @IBOutlet weak var joinButton: CustomButton!
    
    @IBAction func randomGameAction(_ sender: Any) {
        let words: [String] = SocketIOManager.sharedInstance.receiveWords()
        print("^^^^^^^^")
//        SocketIOManager.sharedInstance.getPlayers()
        for word in words {
            print(word)
        }
        print("^^^^^^^^")
        
    }
    
    //MARK: Keyboard management
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        adjustLayoutForKeyboard(targetHight: keyboardFrame.size.height)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        adjustLayoutForKeyboard(targetHight: 0)
    }
    
    func adjustLayoutForKeyboard(targetHight: CGFloat){
//        tableView.contentInset.bottom = targetHight
    }
    
    @IBAction func joinGameAction(_ sender: Any) {
        if let caption = fetchInput() {
            GameConstants.roomID = caption
            SocketIOManager.sharedInstance.joinGame(roomID: caption, username: "Player0")
            lobbyCodeTextField.resignFirstResponder()
        }
    }
    
    func manageJoinButton(){
        var enabled = false
        if let caption = fetchInput() {
            if caption.count > 0 {  //useless?!
                enabled = true
            }
        }
        joinButton.isEnabled = enabled
    }
    
    func fetchInput() -> String? {
        if let caption = lobbyCodeTextField.text?.trimmingCharacters(in: .whitespaces) {
            return caption.count > 0 ? caption : nil
        }
        return nil
    }
    
    //MARK: UI handling
    func setRandomGameButtonAttributes() {
        randomGameButton.setCornerRadius(radius: 30)
        randomGameButton.setShadowColor(color: Colors.blue.componentColor!)
        randomGameButton.setBackgroundColor(color: Colors.blue.componentColor!)
    }
    
    func setLobbyCodeTextFieldAttributes() {
        lobbyCodeTextField.layer.cornerRadius = 20
        lobbyCodeTextField.backgroundColor = Colors.gray.componentColor!.topBackground
    }
    
    func setJoinButtonAttributrs() {
        joinButton.setCornerRadius(radius: 20.5)
        joinButton.setShadowColor(color: Colors.pink.componentColor!)
        joinButton.setBackgroundColor(color: Colors.pink.componentColor!)
    }
    
    func configure() {
        setRandomGameButtonAttributes()
        setLobbyCodeTextFieldAttributes()
        setJoinButtonAttributrs()
        
        lobbyCodeTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
        
        SocketIOManager.sharedInstance.shareStatus()
    }
}
