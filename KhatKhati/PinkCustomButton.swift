//
//  PinkCustomButton.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class PinkCustomButton: CustomButton {
    func setBackgroundColor(){
        let gLayer = super.gradientLayer()
        
        let topColor = UIColor(red: 255/255, green: 0/255, blue: 244/255, alpha: 1).cgColor
        let bottomColor = UIColor(red: 255/255, green: 11/255, blue: 150/255, alpha: 1).cgColor
        gLayer.colors = [topColor, bottomColor]
        
        self.layer.insertSublayer(gLayer, at: 0)
    }
    
    func setShadowColor(){
        self.layer.shadowColor = UIColor(red: 240/255, green: 6/255, blue: 197/255, alpha: 0.37).cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setBackgroundColor()
        setShadowColor()
    }
}
