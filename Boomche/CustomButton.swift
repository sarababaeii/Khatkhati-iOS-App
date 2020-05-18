//
//  CustomButton.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            
            if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer {
                topLayer.cornerRadius = self.cornerRadius
            }
        }
    }
    
    @IBInspectable var lightGradientColor: UIColor = UIColor.white {
        didSet{
            self.setGradient()
        }
    }
    
    @IBInspectable var darkGradientColor: UIColor = UIColor.white {
        didSet{
            self.setGradient()
        }
    }
    
    private func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.colors = [lightGradientColor.cgColor, darkGradientColor.cgColor]
        
        removeGradient()
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeGradient() {
        if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer {
            topLayer.removeFromSuperlayer()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.white {
        didSet {
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowAlpha: Float = 1 {
        didSet {
            self.layer.shadowOpacity = self.shadowAlpha
        }
    }
    
    @IBInspectable var shadowSize: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = self.shadowSize
        }
    }
    
    @IBInspectable var shadowBlur: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = self.shadowBlur
        }
    }
    
    @IBInspectable var maskToBounds: Bool = false {
        didSet {
            self.layer.masksToBounds = self.maskToBounds
        }
    }
    
    func setImage(image: UIImage) {
        let view = UIView()
        view.frame = self.bounds

        let imageView = UIImageView(frame: CGRect(x: 15, y: 15, width: image.size.width, height: image.size.height))
        imageView.image = image

        self.insertSubview(imageView, aboveSubview: view)
    }
}
