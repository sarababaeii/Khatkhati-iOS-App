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
    
    var color: UIColor?
    
    func setCornerRadius(radius: CGFloat){
            self.layer.cornerRadius = radius
        }
    
    func setBackgroundColor(color: Color) {
        self.color = color.topBackground
        
        if let bottomBackground = color.bottomBackground {
            let gradientLayer = CAGradientLayer()
//            gradientLayer.type = .radial
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = self.layer.cornerRadius //must be called after setCornerRadius
            
            gradientLayer.colors = [color.topBackground.cgColor, bottomBackground.cgColor]
            
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        else {
            self.layer.backgroundColor = color.topBackground.cgColor
        }
    }
    
    func setShadowColor(color: Color){
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 8.0
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = color.shadow?.cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
