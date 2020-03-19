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
    
    func setRoundedCorner(){
        self.layer.cornerRadius = 30.5
    }
    
    func setShadowSize(){
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 8.0
        self.layer.masksToBounds = false
    }
    
    func gradientLayer() -> CAGradientLayer{
        let layer = CAGradientLayer()
        layer.type = .radial
        layer.frame = self.bounds
        layer.cornerRadius = 30.5
        
        return layer
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setRoundedCorner()
        setShadowSize()
    }
}
