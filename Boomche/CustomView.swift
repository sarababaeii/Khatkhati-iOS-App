//
//  CustomView.swift
//  Boomche
//
//  Created by Sara Babaei on 5/18/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
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
}
