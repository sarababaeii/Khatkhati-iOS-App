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
    
    @IBInspectable var image: UIImage? {
        didSet {
            self.setImage(image: image!)
        }
    }
    
    @IBInspectable var coordinate: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            self.setImage(image: image!, coordinate: coordinate)
        }
    }
    
    var overImageView: UIImageView?
    
    func setImage(image: UIImage, coordinate: CGPoint = CGPoint(x: 0, y: 0)) {
        let view = UIView()
        view.frame = self.bounds

        let imageView = UIImageView(frame: CGRect(origin: coordinate, size: image.size))
//        let imageView = UIImageView(frame: CGRect(x: 15, y: 15, width: image.size.width, height: image.size.height))
        imageView.image = image

        overImageView?.removeFromSuperview()
        self.insertSubview(imageView, aboveSubview: view)
        overImageView = imageView
    }
    
    //MARK: For NewLobbyViewController Settings
    func select(isTypeButton: Bool) {
        self.setTitleColor(Colors.white.componentColor?.lightBackground, for: .normal)
        self.isEnabled = false
        if isTypeButton {
            self.lightGradientColor = Colors.blue.componentColor!.lightBackground
            self.darkGradientColor = Colors.blue.componentColor!.darkBackground!
        } else {
            self.lightGradientColor = Colors.yellow.componentColor!.lightBackground
            self.darkGradientColor = Colors.yellow.componentColor!.darkBackground!
        }
    }
    
    func unselect() {
        self.removeGradient()
        self.setTitleColor(Colors.dusk.componentColor?.lightBackground, for: .normal)
        if Game.sharedInstance.me.isLobbyLeader {
            self.isEnabled = true
        }
    }
    
    func isSelected() -> Bool {
        return (self.titleLabel?.textColor == Colors.white.componentColor?.lightBackground)
    }
}
