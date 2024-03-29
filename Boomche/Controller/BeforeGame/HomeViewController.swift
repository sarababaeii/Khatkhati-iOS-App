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
        SocketIOManager.sharedInstance.requestRoomID()
        createLobbyButton.layer.masksToBounds = true //to showing button selected
    }
    
    func configure(){
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
