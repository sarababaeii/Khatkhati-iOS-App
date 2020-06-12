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
    
    @IBOutlet weak var randomGameButton: UIButton!
    @IBOutlet weak var lobbyCodeTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
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
    
    func configure() {
        Game.sharedInstance.gameFinished()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setGradientSizes()
    }
}
