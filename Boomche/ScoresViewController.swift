//
//  ScoresViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 4/3/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class ScoresViewController: UIViewController {
   
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var scoresTableView: UITableView!
    
    //MARK: Timer Setting
    func setTimer() {
        var time = 10
        if Game.sharedInstance.joinedState == 2 {
            time = Game.sharedInstance.time!
        }
        timerLabel.text = String(time).convertEnglishNumToPersianNum()
        let timer = TimerSetting(label: timerLabel, time: time)
        timer.on()
    }
    
    //MARK: Initializing
    func initializeVariables() {
        Game.sharedInstance.round.scoreboardTableViewDelegates = ScoreboardTableViewDelegates(scoreboardTableView: scoresTableView, isEndGame: false)
        scoresTableView.delegate = Game.sharedInstance.round.scoreboardTableViewDelegates
        scoresTableView.dataSource = Game.sharedInstance.round.scoreboardTableViewDelegates
    }
    
    //MARK: UI Handling
    func setWordLabelAttributes() {
        wordLabel.text = Game.sharedInstance.round.word
    }
    
    func configure() {
        setWordLabelAttributes()
        initializeVariables()
        setTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}
