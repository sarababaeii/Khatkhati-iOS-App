//
//  StringExtension.swift
//  Boomche
//
//  Created by Sara Babaei on 4/18/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation

class StringExtension {
    static func convertEnglishNumToPersianNum(num: String) -> String {
        let format = NumberFormatter()
        format.locale = Locale(identifier: "fa_IR")
        
        let number =   format.number(from: num)
        let faNumber = format.string(from: number!)
        
        return faNumber!
    }
}
