//
//  NewLobbyViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class NewLobbyViewController: UIViewController {
    @IBOutlet weak var copyButton: CustomButton!
    @IBOutlet weak var nameLabel: CustomLabel!
    
    func setCopyButtonAttributes(){
        copyButton.setCornerRadius(radius: 21)
        copyButton.setShadowColor(red: 240/255, green: 6/255, blue: 197/255, alpha: 0.37)
        copyButton.setBackgroundColor(topRed: 255/255, topGreen: 0/255, topBlue: 244/255, topAlpha: 1,
                                          bottomRed: 255/255, bottomGreen: 11/255, bottomBlue: 150/255, bottomAlpha: 1)
    }
    
    func setNameLabelAttributes(){
        nameLabel.layer.cornerRadius = 30.5
//        nameLabel.setCornerRadius(radius: 30.5)
        nameLabel.setBackgroundColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    }
    
    func configure() {
        setCopyButtonAttributes()
        setNameLabelAttributes()
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        
        configure()
       }
}
