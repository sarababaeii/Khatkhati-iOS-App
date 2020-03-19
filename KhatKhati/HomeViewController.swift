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
        createLobbyButton.layer.masksToBounds = true
    }
    
    func setJoinGameButtonAttributes(){
        joinGameButton.setCornerRadius(radius: 30.5)
        joinGameButton.setShadowColor(red: 254/255, green: 205/255, blue: 0/255, alpha: 0.55)
        joinGameButton.setBackgroundColor(topRed: 255/255, topGreen: 215/255, topBlue: 0/255, topAlpha: 1,
                                          bottomRed: 254/255, bottomGreen: 189/255, bottomBlue: 0/255, bottomAlpha: 1)
    }
    
    func setCreateLobbyButtonAttributes(){
        createLobbyButton.setCornerRadius(radius: 30.5)
        createLobbyButton.setShadowColor(red: 2/255, green: 156/255, blue: 255/255, alpha: 0.4)
        createLobbyButton.setBackgroundColor(topRed: 0/255, topGreen: 177/255, topBlue: 255/255, topAlpha: 1,
                                             bottomRed: 3/255, bottomGreen: 138/255, bottomBlue: 255/255, bottomAlpha: 1)
    }
    
    func configure(){
        setJoinGameButtonAttributes()
        setCreateLobbyButtonAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
    }


}

