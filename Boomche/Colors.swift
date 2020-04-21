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
    case blue
    case yellow
    case pink
    case green
    case gray
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
        case .blue:
            return Color.init(topBackground:UIColor(red: 0/255, green: 177/255, blue: 255/255, alpha: 1),
                              bottomBackground: UIColor(red: 3/255, green: 138/255, blue: 255/255, alpha: 1),
                              shadow: UIColor(red: 2/255, green: 156/255, blue: 255/255, alpha: 0.4))
        case .yellow:
            return Color.init(topBackground: UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1),
                              bottomBackground: UIColor(red: 254/255, green: 189/255, blue: 0/255, alpha: 1),
                              shadow: UIColor(red: 254/255, green: 205/255, blue: 0/255, alpha: 0.55))
        case .pink:
            return Color.init(topBackground: UIColor(red: 255/255, green: 0/255, blue: 244/255, alpha: 1),
                              bottomBackground: UIColor(red: 255/255, green: 11/255, blue: 150/255, alpha: 1),
                              shadow: UIColor(red: 240/255, green: 6/255, blue: 197/255, alpha: 0.37))
        case .green:
            return Color.init(topBackground: UIColor(red: 29/255, green: 210/255, blue: 0/255, alpha: 1),
                              bottomBackground: UIColor(red: 8/255, green: 186/255, blue: 12/255, alpha: 1),
                              shadow: UIColor(red: 29/255, green: 198/255, blue: 6/255, alpha: 0.5))
        case .gray:
            return Color.init(topBackground: UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1),
                              shadow: UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 0.35),
                              border: UIColor(red: 241/255, green: 244/255, blue: 255/255, alpha: 1))

        default:
            return nil
        }
    }

    var drawingColor: Color? {
        switch self {
        case .red:
            return Color.init(topBackground: UIColor(red: 245/255, green: 1/255, blue: 6/255, alpha: 1),
                              bottomBackground: UIColor(red: 212/255, green: 6/255, blue: 6/255, alpha: 1))
        case .green:
            return Color.init(topBackground: UIColor(red: 52/255, green: 232/255, blue: 22/255, alpha: 1),
                              bottomBackground: UIColor(red: 85/255, green: 193/255, blue: 8/255, alpha: 1))
        case .darkBlue:
            return Color.init(topBackground: UIColor(red: 22/255, green: 80/255, blue: 232/255, alpha: 1),
                              bottomBackground: UIColor(red: 11/255, green: 19/255, blue: 175/255, alpha: 1))
        case .yellow:
            return Color.init(topBackground: UIColor(red: 255/255, green: 213/255, blue: 0/255, alpha: 1),
                              bottomBackground: UIColor(red: 229/255, green: 199/255, blue: 29/255, alpha: 1))
        case .purple:
            return Color.init(topBackground: UIColor(red: 201/255, green: 0/255, blue: 255/255, alpha: 1),
                              bottomBackground: UIColor(red: 147/255, green: 29/255, blue: 229/255, alpha: 1))
        case .pink:
            return Color.init(topBackground: UIColor(red: 255/255, green: 0/255, blue: 218/255, alpha: 1),
                              bottomBackground: UIColor(red: 221/255, green: 23/255, blue: 181/255, alpha: 1))
        case .brown:
            return Color.init(topBackground: UIColor(red: 134/255, green: 65/255, blue: 4/255, alpha: 1),
                              bottomBackground: UIColor(red: 104/255, green: 41/255, blue: 0/255, alpha: 1))
        case .lightBlue:
            return Color.init(topBackground: UIColor(red: 22/255, green: 215/255, blue: 227/255, alpha: 1),
                              bottomBackground: UIColor(red: 0/255, green: 179/255, blue: 183/255, alpha: 1))
        case .black:
            return Color.init(topBackground: UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1),
                              bottomBackground: UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1))
        case .gray:
            return Color.init(topBackground: UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1),
                              bottomBackground: UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1))
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
