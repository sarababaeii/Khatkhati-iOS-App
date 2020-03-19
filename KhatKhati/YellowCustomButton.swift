//
//  YellowCustomButton.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class YellowCustomButton: CustomButton {
    func setBackgroundColor(){
        let gLayer = super.gradientLayer()
        
        let topColor = UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1).cgColor
        let bottomColor = UIColor(red: 254/255, green: 189/255, blue: 0/255, alpha: 1).cgColor
        gLayer.colors = [topColor, bottomColor]
        
        self.layer.insertSublayer(gLayer, at: 0)
    }
    
    func setShadowColor(){
        self.layer.shadowColor = UIColor(red: 254/255, green: 205/255, blue: 0/255, alpha: 0.55).cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setBackgroundColor()
        setShadowColor()
    }
    
}
