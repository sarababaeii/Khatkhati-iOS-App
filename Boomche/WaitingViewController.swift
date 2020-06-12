//
//  WaitingViewController.swift
//  Boomche
//
//  Created by Sara Babaei on 4/16/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class WaitingViewController: UIViewController {
   
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var chooserNameLabel: UILabel!

    static var parentViewController: UIViewController?
    
    //MARK: Timer Setting
    func setTimer() {
        var time = 10
        if Game.sharedInstance.joinedState == 3 {
            time = Game.sharedInstance.time!
        }
        timerLabel.text = "۰:" + String(time).convertEnglishNumToPersianNum()
        _ = TimerSetting(label: timerLabel, time: time, from: self)
    }
    
    func setChooserNameLabelAttributes() {
        if let painter = Game.sharedInstance.round.painter {
            chooserNameLabel.text = painter.username
            chooserNameLabel.textColor = painter.color.lightBackground
        }
    }
    
    func configure() {
        setChooserNameLabelAttributes()
        
        setTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}
