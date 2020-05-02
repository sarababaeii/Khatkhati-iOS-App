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
    var topBackground: UIColor
    var bottomBackground: UIColor?
    var shadow: UIColor?
    var border: UIColor?
    
    init(_ color: UIColor) {
        topBackground = color
    }
    
    convenience init(topBackground: UIColor, shadow: UIColor, border: UIColor) {
        self.init(topBackground)
        self.shadow = shadow
        self.border = border
    }
    
    convenience init(topBackground: UIColor, bottomBackground: UIColor) {
        self.init(topBackground)
        self.bottomBackground = bottomBackground
    }
    
    convenience init(topBackground: UIColor, bottomBackground: UIColor, shadow: UIColor) {
        self.init(topBackground: topBackground, bottomBackground: bottomBackground)
        self.shadow = shadow
    }
}
