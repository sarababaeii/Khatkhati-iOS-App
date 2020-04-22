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
    
    static var chooserName = "سارا"
    
    //MARK: Socket Management
    func addSocketHandler() {
        SocketIOManager.sharedInstance.socket?.on("lets_play") { data, ack in
            print("^^^^^GAME STARTED^^^^^^")
            
            self.dismiss(animated: true, completion: nil)
        }
    }

    //MARK: Timer Setting
    func setTimer() {
        let timer = TimerSetting(label: timerLabel, time: 10)
        timer.on()
    }
    
    func setMainViewAttributes() {
        mainView.layer.cornerRadius = 29
    }
    
    func setChooserNameLabelAttributes() {
        //TODO: Setting name and color of chooser given from server
        chooserNameLabel.text = WaitingViewController.chooserName
    }
    
    func configure() {
        setMainViewAttributes()
        setChooserNameLabelAttributes()
        
        setTimer()
        
        addSocketHandler()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}
