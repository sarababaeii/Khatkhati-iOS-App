//
//  Timer.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/30/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class TimerSetting {
    var label: UILabel
    var counter = 60
    
    init(label: UILabel) {
        self.label = label
    }
    
    func on() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if counter >= 0 {
            counter -= 1
            label.text = "۰:\(convertEnglishNumToPersianNum(num: "\(counter)"))"
        }
    }
    
    func convertEnglishNumToPersianNum(num: String) -> String {
        //let number = NSNumber(value: Int(num)!)
        let format = NumberFormatter()
        format.locale = Locale(identifier: "fa_IR")
        
        let number =   format.number(from: num)
        let faNumber = format.string(from: number!)
        
        return faNumber!
    }
}
