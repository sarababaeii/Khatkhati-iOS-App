//
//  ScoresViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 4/3/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class ScoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var scoresTableView: UITableView!
    
    var players = [Player]()
    
    //MARK: Timer Setting
    func setTimer() {
        let timer = TimerSetting(label: timerLabel, time: 10)
        timer.on()
    }
    
    //MARK: TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCellID", for: indexPath) as! ScoreTableViewCell
        let player = playerDataSource(indexPath: indexPath)
        cell.setAttributes(player: player!)
        cell.layer.borderWidth = 4
//        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.borderColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 0.84).cgColor
        return cell
    }
    
    func playerDataSource(indexPath: IndexPath) -> Player? {
        return players[indexPath.row]
    }
    
    func initialPlayers() {
        players.removeAll()
        
        players.append(Player(username: "سارا", color: Colors.red.playerColor!, totalScore: 210, currentScore: 25))
        players.append(Player(username: "Mohammad", color: Colors.green.playerColor!, totalScore: 190, currentScore: 0))
        players.append(Player(username: "عماد", color: Colors.orange.playerColor!, totalScore: 150, currentScore: 10))
        players.append(Player(username: "iamarshiamajidi", color: Colors.purple.playerColor!, totalScore: 130, currentScore: 35))
        players.append(Player(username: "امیر", color: Colors.darkBlue.playerColor!, totalScore: 100, currentScore: 0))
        players.append(Player(username: "سجاد رضایی‌پور", color: Colors.lightBlue.playerColor!, totalScore: 50, currentScore: 5))
        
        players[2].isPainter = true
        players[3].isFirstGuesser = true
    }
    
    func configure() {
        scoresTableView.delegate = self
        scoresTableView.dataSource = self
        
        initialPlayers()
        
        setTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}

//TODO: Border, corner, clean
