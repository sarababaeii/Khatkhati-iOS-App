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
    
    func setBackgroundColor(topRed: CGFloat, topGreen: CGFloat, topBlue: CGFloat, topAlpha: CGFloat,
                            bottomRed: CGFloat, bottomGreen: CGFloat, bottomBlue: CGFloat, bottomAlpha: CGFloat){
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius //must be called after setCornerRadius
        
        let topColor = UIColor(red: topRed, green: topGreen, blue: topBlue, alpha: topAlpha).cgColor
        let bottomColor = UIColor(red: bottomRed, green: bottomGreen, blue: bottomBlue, alpha: bottomAlpha).cgColor
        
        gradientLayer.colors = [topColor, bottomColor]
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setShadowColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat){
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 8.0
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
