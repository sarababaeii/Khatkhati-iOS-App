//
//  CustomButton.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setAttributes(color: Color, radius: CGFloat, hasShadow: Bool) {
        self.layer.cornerRadius = radius
        
        setBackground(color: color, radius: radius)
        
        if hasShadow {
            setShadowColor(color)
        }
    }
    
    func setBackground(color: Color, radius: CGFloat) {
        if let _ = color.darkBackground {
            setGradientBackground(color: color, radius: radius)
        } else {
            self.layer.backgroundColor = color.lightBackground.cgColor
        }
    }
    
    func setGradientBackground(color: Color, radius: CGFloat) {
        let gradientLayer = CAGradientLayer()
//        gradientLayer.type = .radial
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = radius
        gradientLayer.colors = [color.lightBackground.cgColor, color.darkBackground!.cgColor]
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setShadowColor(_ color: Color){
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 8.0
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = color.shadow?.cgColor
    }
    
    func setImage(image: UIImage) {
        let view = UIView()
        view.frame = self.bounds
        
        let imageView = UIImageView(frame: CGRect(x: 15, y: 15, width: image.size.width, height: image.size.height))
        imageView.image = image

        self.insertSubview(imageView, aboveSubview: view)
    }
}
