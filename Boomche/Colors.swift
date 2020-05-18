//
//  Blue.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/20/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

enum Colors {
    case yellow
    case blue
    case pink
    case green
    case gray
    case dusk
    case red
    case darkBlue
    case purple
    case brown
    case lightBlue
    case black
    case white
    case orange
    
    //MARK: Component Colors
    var componentColor: Color? {
        switch self {
        case .yellow:
            return Color.init(lightBackground: UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1),
                              darkBackground: UIColor(red: 254/255, green: 189/255, blue: 0/255, alpha: 1),
                              shadow: UIColor(red: 254/255, green: 205/255, blue: 0/255, alpha: 0.55))
        case .blue:
            return Color.init(lightBackground:UIColor(red: 0/255, green: 177/255, blue: 255/255, alpha: 1),
                          darkBackground: UIColor(red: 3/255, green: 138/255, blue: 255/255, alpha: 1),
                          shadow: UIColor(red: 2/255, green: 156/255, blue: 255/255, alpha: 0.4))
        case .pink:
            return Color.init(lightBackground: UIColor(red: 255/255, green: 0/255, blue: 244/255, alpha: 1),
                              darkBackground: UIColor(red: 255/255, green: 11/255, blue: 150/255, alpha: 1),
                              shadow: UIColor(red: 240/255, green: 6/255, blue: 197/255, alpha: 0.37))
        case .green:
            return Color.init(lightBackground: UIColor(red: 29/255, green: 210/255, blue: 0/255, alpha: 1),
                              darkBackground: UIColor(red: 8/255, green: 186/255, blue: 12/255, alpha: 1),
                              shadow: UIColor(red: 29/255, green: 198/255, blue: 6/255, alpha: 0.5))
        case .gray:
            return Color.init(lightBackground: UIColor(red: 241/255, green: 244/255, blue: 255/255, alpha: 1),
                              shadow: UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1),
                              border: UIColor(red: 210/255, green: 208/255, blue: 244/255, alpha: 1))
        case .dusk:
            return Color.init(UIColor(red: 59/255, green: 57/255, blue: 89/255, alpha: 1))
        case .white:
            return Color.init(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
        default:
            return nil
        }
    }

    var drawingColor: Color? {
        switch self {
        case .purple:
            return Color.init(UIColor(red: 98/255, green: 49/255, blue: 141/255, alpha: 1))
        case .green:
            return Color.init(UIColor(red: 63/255, green: 188/255, blue: 103/255, alpha: 1))
        case .brown:
            return Color.init(UIColor(red: 130/255, green: 96/255, blue: 70/255, alpha: 1))
        case .lightBlue:
            return Color.init(UIColor(red: 34/255, green: 185/255, blue: 228/255, alpha: 1))
        case .darkBlue:
            return Color.init(UIColor(red: 32/255, green: 136/255, blue: 192/255, alpha: 1))
        case .red:
            return Color.init(UIColor(red: 244/255, green: 58/255, blue: 59/255, alpha: 1))
        case .orange:
            return Color.init(UIColor(red: 250/255, green: 132/255, blue: 62/255, alpha: 1))
        case .yellow:
            return Color.init(UIColor(red: 255/255, green: 223/255, blue: 70/255, alpha: 1))
        case .black:
            return Color.init(UIColor(red: 48/255, green: 40/255, blue: 43/255, alpha: 1))
        case .gray:
            return Color.init(UIColor(red: 243/255, green: 243/255, blue: 246/255, alpha: 1))
        case .white:
            return Color.init(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
        default:
            return nil
        }
    }
    
    var playerColor: Color? {
        switch self {
        case .red:
            return Color.init(UIColor(red: 255/255, green: 53/255, blue: 95/255, alpha: 1))
        case .green:
            return Color.init(UIColor(red: 0/255, green: 191/255, blue: 125/255, alpha: 1))
        case .orange:
            return Color.init(UIColor(red: 251/255, green: 120/255, blue: 67/255, alpha: 1))
        case .purple:
            return Color.init(UIColor(red: 199/255, green: 2/255, blue: 254/255, alpha: 1))
        case .darkBlue:
            return Color.init(UIColor(red: 67/255, green: 104/255, blue: 251/255, alpha: 1))
        case .lightBlue:
            return Color.init(UIColor(red: 109/255, green: 210/255, blue: 255/255, alpha: 1))
        default:
            return nil
        }
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
