//
//  ViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var joinGameButton: CustomButton!
    @IBOutlet weak var createLobbyButton: CustomButton!
    
    
    @IBAction func createLobbyAction(_ sender: Any) {
        SocketIOManager.sharedInstance.creatLobby()
        createLobbyButton.layer.masksToBounds = true //to showing button selected
    }
    
    //MARK: UI Handling
    func setJoinGameButtonAttributes(){
        joinGameButton.setCornerRadius(radius: 30.5)
        joinGameButton.setShadowColor(color: Colors.yellow.componentColor!)
        joinGameButton.setBackgroundColor(color: Colors.yellow.componentColor!)
    }
    
    func setCreateLobbyButtonAttributes(){
        createLobbyButton.setCornerRadius(radius: 30.5)
        createLobbyButton.setShadowColor(color: Colors.blue.componentColor!)
        createLobbyButton.setBackgroundColor(color: Colors.blue.componentColor!)
    }
    
    func configure(){
        Game.sharedInstance.isLobbyLeader = false
        
        setJoinGameButtonAttributes()
        setCreateLobbyButtonAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        configure()
        SocketIOManager.sharedInstance.shareStatus()
    }
}
