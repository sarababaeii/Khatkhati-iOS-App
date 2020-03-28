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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
        
        SocketIOManager.sharedInstance.shareStatus()
    }
}
