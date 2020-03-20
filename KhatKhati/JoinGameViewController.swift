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
    
    func setRandomGameButtonAttributes() {
        randomGameButton.setCornerRadius(radius: 32.5)
        randomGameButton.setShadowColor(color: Colors.blue)
        randomGameButton.setBackgroundColor(color: Colors.blue)
    }
    
    func configure() {
        setRandomGameButtonAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
     configure()
    }
}
