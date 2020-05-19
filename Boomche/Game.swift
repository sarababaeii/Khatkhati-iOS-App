//
//  Game.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/31/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation

class Game {
    static var sharedInstance = Game()
    
    //MARK: Personal Information
    var me = Player(username: "سارا")
    
    //MARK: Game Information
    var roomID: String?
    var lobbyType = "Private"
    var roundsNumber = 6
    
    var players = [Player]()
    
    var round = RoundData()
    
    func getPlayerWith(username: String) -> Player? { //socketID
        for player in players {
            if player.username == username { //socketID
                return player
            }
        }
        return nil
    }
    
    func gameFinished() {
        roomID = nil
        lobbyType = "Private"
        roundsNumber = 6
        
        players = [Player]()
        
        me.gameFinished()
        roundFinished()
    }

    func roundFinished() {
        round.roundFinished()
        for player in players {
            player.roundFinished()
        }
    }
}
        
//TODO: Play again
