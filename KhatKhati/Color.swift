//
//  ComponentColor.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/20/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class Color {
    var topBackground: UIColor
    var bottomBackground: UIColor
    var shadow: UIColor?
    
    init(topBackground: UIColor, bottomBackground: UIColor) {
        self.topBackground = topBackground
        self.bottomBackground = bottomBackground
    }
    
    convenience init(topBackground: UIColor, bottomBackground: UIColor, shadow: UIColor) {
        self.init(topBackground: topBackground, bottomBackground: bottomBackground)
        self.shadow = shadow
    }
}
