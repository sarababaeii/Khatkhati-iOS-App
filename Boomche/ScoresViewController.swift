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
    
    static var word = ""
    static var users = [[String : Any]]()
    
    static var isLastRound = false
    
    var players = [Player]()
    
    //MARK: Timer Setting
    func setTimer() {
        let timer = TimerSetting(label: timerLabel, time: 10)
        if ScoresViewController.isLastRound {
            timer.from = self   //TODO: Clean it
        }
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
        return cell
    }
    
    func playerDataSource(indexPath: IndexPath) -> Player? {
        return players[indexPath.row]
    }
    
    func initialPlayers() {
        players.removeAll()
        
        for user in ScoresViewController.users {
            players.append(Player(username: user["name"] as! String, color: Colors.red.playerColor!, totalScore: user["score"] as! Int, currentScore: user["current_score"] as! Int))
        }
        
        if ScoresViewController.isLastRound {
            if players.count > 0 {
                EndGameViewController.winnerPlayer = players[0]
            }
            if players.count > 1 {
                EndGameViewController.secondPlacePlayer = players[1]
            }
            if players.count > 2 {
                EndGameViewController.thirdPlacePlayer = players[2]
            }
        }
    }
    
    //MARK: UI Handling
    func setWordLabelAttributes() {
        wordLabel.text = ScoresViewController.word
    }
    
    func configure() {
        setWordLabelAttributes()
        
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
