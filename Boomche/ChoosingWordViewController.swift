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
    
    @IBOutlet weak var firstWordButton: CustomButton!
    @IBOutlet weak var secondWordButton: CustomButton!
    @IBOutlet weak var thirdWordButton: CustomButton!
    
    var buttons = [CustomButton]()
    static var words: [String]?
    
    @IBAction func chooseWord(_ sender: Any) {
        SocketIOManager.sharedInstance.sendWord(word: (sender as! UIButton).currentTitle!)
    }
    
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
    
    func initialize() {
        buttons = [firstWordButton, secondWordButton, thirdWordButton]
//        ChoosingWordViewController.words = SocketIOManager.sharedInstance.receiveWords()
    }
    
    //MARK: UI Handling
    func setButtonsAttributes() {
        for button in buttons {
            button.setCornerRadius(radius: 30.5)
            button.setBackgroundColor(color: Colors.yellow.componentColor!)
            
            if let word = ChoosingWordViewController.words?[button.tag] {
                button.setTitle(word, for: .normal)
            }
        }
    }
    
    func configure() {
        initialize()
        
        setButtonsAttributes()
        
        setTimer()
        
        addSocketHandler()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}
