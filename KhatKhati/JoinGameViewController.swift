//
//  JoinGameViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/20/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class JoinGameViewController: UIViewController {
    
    @IBOutlet weak var randomGameButton: CustomButton!
    @IBOutlet weak var lobbyCodeTextField: UITextField!
    @IBOutlet weak var joinButton: CustomButton!
    
    func setRandomGameButtonAttributes() {
        randomGameButton.setCornerRadius(radius: 30)
        randomGameButton.setShadowColor(color: Colors.blue)
        randomGameButton.setBackgroundColor(color: Colors.blue)
    }
    
    func setLobbyCodeTextFieldAttributes() {
        lobbyCodeTextField.layer.cornerRadius = 20
        lobbyCodeTextField.backgroundColor = Colors.gray.topBackground
        lobbyCodeTextField.layer.borderColor = Colors.gray.topBackground.cgColor
    }
    
    func setJoinButtonAttributrs() {
        joinButton.setCornerRadius(radius: 21.5)
        joinButton.setShadowColor(color: Colors.pink)
        joinButton.setBackgroundColor(color: Colors.pink)
    }
    
    func configure() {
        setRandomGameButtonAttributes()
        setLobbyCodeTextFieldAttributes()
        setJoinButtonAttributrs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
     configure()
    }
}
