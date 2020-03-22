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
        randomGameButton.setShadowColor(color: ComponentColors.blue)
        randomGameButton.setBackgroundColor(color: ComponentColors.blue)
    }
    
    func setLobbyCodeTextFieldAttributes() {
        lobbyCodeTextField.layer.cornerRadius = 20
        lobbyCodeTextField.backgroundColor = ComponentColors.gray.topBackground
        lobbyCodeTextField.layer.borderColor = ComponentColors.gray.topBackground.cgColor
    }
    
    func setJoinButtonAttributrs() {
        joinButton.setCornerRadius(radius: 21.5)
        joinButton.setShadowColor(color: ComponentColors.pink)
        joinButton.setBackgroundColor(color: ComponentColors.pink)
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
