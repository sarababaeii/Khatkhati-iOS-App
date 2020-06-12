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

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
