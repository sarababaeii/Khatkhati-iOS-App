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
    
    @IBOutlet weak var randomGameButton: CustomButton!
    @IBOutlet weak var lobbyCodeTextField: UITextField!
    @IBOutlet weak var joinButton: CustomButton!
    
    @IBAction func randomGameAction(_ sender: Any) {
        SocketIOManager.sharedInstance.findGame()
        showNextPage(identifier: "LoadingViewController")
    }
    
    @IBAction func joinGameAction(_ sender: Any) {
        if let caption = lobbyCodeTextField.fetchInput() {
            SocketIOManager.sharedInstance.joinGame(roomID: caption)
            lobbyCodeTextField.resignFirstResponder()
            
            self.showNextPage(identifier: "NewLobbyViewController")
        }
    }
    
    //MARK: Keyboard management
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lobbyCodeTextField.resignFirstResponder()
    }

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
        //TODO: joinButton.bottom = targetHight
    }
    
    func configure() {
        Game.sharedInstance.gameFinished()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
//        print("heeeeeeeeey \(self.getSubviews(view: self.view)?.count as Any)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setGradientSizes()
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        randomGameButton.gradientLayer.frame = randomGameButton.bounds
//        joinButton.gradientLayer.frame = joinButton.bounds
//    }
}
