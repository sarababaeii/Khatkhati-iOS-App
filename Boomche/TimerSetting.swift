//
//  TimerSetting.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/30/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class TimerSetting {
    var label: UILabel
    var counter: Int
    
    init(label: UILabel, time: Int) {
        self.label = label
        self.counter = time
    }
    
    func on() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
        if counter > 0 {
            counter -= 1
            label.text = "۰:\(String(counter).convertEnglishNumToPersianNum())"
        }
    }
}
