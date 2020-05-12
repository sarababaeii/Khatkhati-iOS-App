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
    let gradientLayer = CAGradientLayer()
    
    func setCornerRadius(radius: CGFloat){
        self.layer.cornerRadius = radius
        gradientLayer.cornerRadius = radius
    }
    
    func setBackgroundColor(color: Color) {
        self.color = color.lightBackground
        
        if let darkBackground = color.darkBackground {
            
//            gradientLayer.type = .radial
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = self.layer.cornerRadius
            
            gradientLayer.colors = [color.lightBackground.cgColor, darkBackground.cgColor]
            
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        else {
            self.layer.backgroundColor = color.lightBackground.cgColor
        }
    }
    
    func setShadowColor(color: Color){
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
