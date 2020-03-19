//
//  CustomButton.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //corner:
        self.layer.cornerRadius = 30
        
        //shadow:
        self.layer.shadowColor = UIColor(red: 254/255, green: 205/255, blue: 0/255, alpha: 0.55).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 15.0
        self.layer.masksToBounds = false
        
        //gradient:
//        let colorTop =  UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 0).cgColor
//        let colorBottom = UIColor(red: 254/255, green: 189/255, blue: 0/255, alpha: 0).cgColor
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [colorTop, colorBottom]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.frame = self.bounds
//        self.layer.insertSublayer(gradientLayer, at:0)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 0).cgColor, UIColor(red: 254/255, green: 189/255, blue: 0/255, alpha: 0).cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        
//        border-radius: 20px;
//        background-color: #fdbd39;
//        background-color: var(--orange);
//        box-shadow: 0 0 4px 0 #2f333a;
//        box-shadow: 0 0 4px 0 var(--gray);
//        border: solid 2px rgba(255, 255, 255, 0.4);
//        border: solid 2px var(--off-white);
    }
}
