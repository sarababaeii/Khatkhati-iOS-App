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
    
    func setCornerRadius(radius: CGFloat){
            self.layer.cornerRadius = radius
        }
    
    func setBackgroundColor(color: ComponentColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius //must be called after setCornerRadius
        
        gradientLayer.colors = [color.topBackground.cgColor, color.bottomBackground.cgColor]
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setShadowColor(color: ComponentColor){
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 8.0
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = color.shadow.cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override func viewDidLayoutSubviews() {
//       super.viewDidLayoutSubviews()
//       //Update you're layer based on the new frame
////       self.view.addGradientWithColor()
//
//    }
}
