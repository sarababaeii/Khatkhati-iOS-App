//
//  StringExtension.swift
//  Boomche
//
//  Created by Sara Babaei on 4/18/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func convertEnglishNumToPersianNum() -> String {
        let format = NumberFormatter()
        format.locale = Locale(identifier: "fa_IR")
        
        let number =   format.number(from: self)
        let faNumber = format.string(from: number!)
        
        return faNumber!
    }
}

//class StringExtension {
//    static func convertEnglishNumToPersianNum(num: String) -> String {
//        let format = NumberFormatter()
//        format.locale = Locale(identifier: "fa_IR")
//        
//        let number =   format.number(from: num)
//        let faNumber = format.string(from: number!)
//        
//        return faNumber!
//    }
//}
