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
        let timer = TimerSetting(label: timerLabel, time: 10)
        timer.on()
    }
    
    func setChooserNameLabelAttributes() {
        //TODO: Setting name and color of chooser given from server
        chooserNameLabel.text = Game.sharedInstance.painter
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
