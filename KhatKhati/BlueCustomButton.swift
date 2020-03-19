//
//  BlueCustomButton.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class BlueCustomButton: CustomButton {
    func setBackgroundColor(){
        let gLayer = super.gradientLayer()
        
        let topColor = UIColor(red: 0/255, green: 177/255, blue: 255/255, alpha: 1).cgColor
        let bottomColor = UIColor(red: 3/255, green: 138/255, blue: 255/255, alpha: 1).cgColor
        gLayer.colors = [topColor, bottomColor]
        
        self.layer.insertSublayer(gLayer, at: 0)
    }
    
    func setShadowColor(){
        self.layer.shadowColor = UIColor(red: 2/255, green: 156/255, blue: 255/255, alpha: 0.4).cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setBackgroundColor()
        setShadowColor()
    }
}
