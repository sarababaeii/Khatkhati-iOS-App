//
//  CustomView.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/20/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class CustomView: UIView {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
