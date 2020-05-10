//
//  CustomLabel.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setCornerRadius(radius: CGFloat){
            self.layer.cornerRadius = radius
    }
    
    func setBackgroundColor(color: Color){
        self.backgroundColor = color.lightBackground
    }
}
