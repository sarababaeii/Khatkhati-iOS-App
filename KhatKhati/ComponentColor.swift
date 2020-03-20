//
//  ComponentColor.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/20/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class ComponentColor {
    var topBackground: UIColor
    var bottomBackground: UIColor
    var shadow: UIColor
    
    init(topBackground: UIColor, bottomBackground: UIColor, shadow: UIColor) {
        self.topBackground = topBackground
        self.bottomBackground = bottomBackground
        self.shadow = shadow
    }
}
