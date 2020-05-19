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
            let newPlayer = Player(username: user["name"] as! String, colorCode: user["color"] as! Int, totalScore: user["score"] as! Double, currentScore: user["current_score"] as! Double)
            
            if (user["is_drawer"] as? Int) == 1 {
                newPlayer.isPainter = true
            }
            
            players.append(newPlayer)
        }
        
        findFirstGuesser()
        
        if ScoresViewController.isLastRound {
            setWinners()
        }
    }
    
    func findFirstGuesser() {
        var maxCurrentScoreIndex = 0
        
        for i in 0 ..< players.count {
            if !players[i].isPainter && players[i].currentScore > players[maxCurrentScoreIndex].currentScore {
                maxCurrentScoreIndex = i
            }
        }
        if players.count > 0 && players[maxCurrentScoreIndex].currentScore > 0 {
            players[maxCurrentScoreIndex].isFirstGuesser = true
        }
    }
    
    func setWinners() {
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
    
    //MARK: UI Handling
    func setWordLabelAttributes() {
        wordLabel.text = Game.sharedInstance.round.word
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
