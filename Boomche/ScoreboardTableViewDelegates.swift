//
//  ScoreboardTableViewDelegates.swift
//  Boomche
//
//  Created by Sara Babaei on 5/21/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class ScoreboardTableViewDelegates: NSObject, UITableViewDelegate, UITableViewDataSource {
   
    var scoreboardTableView: UITableView!
    var isEndGame: Bool
    
    //MARK: Initializer
    init(scoreboardTableView: UITableView, isEndGame: Bool) {
        self.scoreboardTableView = scoreboardTableView
        self.isEndGame = isEndGame
    }
    
    //MARK: Protocol Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.sharedInstance.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCellID", for: indexPath) as! ScoreTableViewCell
        if let player = playerDataSource(indexPath: indexPath) {
            cell.setAttributes(player: player)
            
            if isEndGame {
                cell.setCupImage(row: indexPath.row)
            } else {
                cell.setBonus(player: player)
            }
        }
        return cell
    }
    
    func playerDataSource(indexPath: IndexPath) -> Player? {
        if indexPath.row < Game.sharedInstance.players.count {
            return Game.sharedInstance.players[indexPath.row]
        }
        return nil
    }
    
    //MARK: Functions
    static func initialScoreboard(users: [[String : Any]]) {
        for user in users {
            let index = Game.sharedInstance.players.firstIndex(where: {$0.username == user["name"] as! String})
            let player =  Game.sharedInstance.players[index!]
            
            player.currentScore = Int(user["current_score"] as! Double)
            player.totalScore = Int(user["score"] as! Double)
            
            Game.sharedInstance.players.remove(at: index!)
            Game.sharedInstance.players.append(player)
        }
        
        findFirstGuesser()
    }
    
    static func findFirstGuesser() {
        var maxCurrentScoreIndex = 0
        
        let players = Game.sharedInstance.players
        for i in 0 ..< players.count {
            if !players[i].isPainter && players[i].currentScore > players[maxCurrentScoreIndex].currentScore {
                maxCurrentScoreIndex = i
            }
        }
        if players.count > 0 && players[maxCurrentScoreIndex].currentScore > 0 {
            players[maxCurrentScoreIndex].isFirstGuesser = true
        }
    }
    
    func setPlayAgain(userIndex row: Int) {
        let cell = scoreboardTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! ScoreTableViewCell
        cell.setPlayAgain()
    }
}
