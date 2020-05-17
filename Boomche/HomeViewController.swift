//
//  ViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var joinGameButton: UIButton!
    @IBOutlet weak var createLobbyButton: UIButton!
    
    @IBAction func createLobbyAction(_ sender: Any) {
        SocketIOManager.sharedInstance.creatLobby()
        createLobbyButton.layer.masksToBounds = true //to showing button selected
    }
    
    //MARK: UI Handling
    func setUIComponentsAttributes() {
        joinGameButton.setAttributes(color: Colors.yellow.componentColor!, radius: 15, hasShadow: false)
        createLobbyButton.setAttributes(color: Colors.blue.componentColor!, radius: 15, hasShadow: false)
    }
    
    func configure(){
        Game.sharedInstance.isLobbyLeader = false
        
        setUIComponentsAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        configure()
    }
}
