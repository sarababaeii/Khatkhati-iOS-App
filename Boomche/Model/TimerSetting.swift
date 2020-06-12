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
    var timer: Timer?
    let label: UILabel
    var counter: Int
    let viewController: UIViewController
    
    init(label: UILabel, time: Int, from viewController: UIViewController) {
        self.label = label
        self.counter = time
        self.viewController = viewController
        
        on()
    }
    
    private func on() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    private func off() {
        timer?.invalidate()
    }
    
    @objc func updateCounter() {
        guard UIApplication.topViewController() == viewController else {
            off()
            return
        }
        
        if counter > 0 {
            counter -= 1
            label.text = "۰:\(String(counter).convertEnglishNumToPersianNum())"
        }
        if counter == 0 {
            off()
            viewController.timerFinished()
        }
    }
}
