//
//  ChoosingWordViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 4/3/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class ChoosingWordViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var firstWordButton: UIButton!
    @IBOutlet weak var secondWordButton: UIButton!
    @IBOutlet weak var thirdWordButton: UIButton!
    
    var buttons = [UIButton]()
    
    static var parentViewController: UIViewController?  //TODO: be clear
    
    @IBAction func chooseWord(_ sender: Any) {
        SocketIOManager.sharedInstance.sendWord(word: (sender as! UIButton).currentTitle!)
    }
    
    //MARK: Timer Setting
    func setTimer() {
        _ = TimerSetting(label: timerLabel, time: 10, from: self)
    }
    
    //MARK: Initializing
    func initialize() {
            buttons = [firstWordButton, secondWordButton, thirdWordButton]
    }
    
    //MARK: UI Handling
    func setUIComponentsAttributes() {
        for button in buttons {
            if button.tag < Game.sharedInstance.round.wordList.count {
                button.setTitle(Game.sharedInstance.round.wordList[button.tag], for: .normal)
            }
        }
    }
    
    func configure() {
        initialize()
        
        setUIComponentsAttributes()
        
        setTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setGradientSizes()
    }
}
