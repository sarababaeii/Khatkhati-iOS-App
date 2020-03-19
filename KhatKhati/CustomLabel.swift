//
//  CustomLabel.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    func setCornerRadius(radius: CGFloat){
            self.layer.cornerRadius = radius
    }
    
    func setBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat){
        self.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
