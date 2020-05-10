//
//  Color.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/20/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class Color {
    var lightBackground: UIColor
    var darkBackground: UIColor?
    var shadow: UIColor?
    var border: UIColor?
    
    init(_ color: UIColor) {
        lightBackground = color
    }
    
    convenience init(lightBackground: UIColor, shadow: UIColor, border: UIColor) {
        self.init(lightBackground)
        self.shadow = shadow
        self.border = border
    }
    
    convenience init(lightBackground: UIColor, darkBackground: UIColor) {
        self.init(lightBackground)
        self.darkBackground = darkBackground
    }
    
    convenience init(lightBackground: UIColor, darkBackground: UIColor, shadow: UIColor) {
        self.init(lightBackground: lightBackground, darkBackground: darkBackground)
        self.shadow = shadow
    }
}
