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
    var players = [Player]()
    var round = RoundData()
    
    var joinedState = 0
    var time: Int?
    
    func roundFinished() {
        round.roundFinished()
        for player in players {
            player.roundFinished()
        }
        joinedState = 0
    }
    
    func playAgain() {
        round.roundFinished()
        for player in players {
            player.playAgain()
        }
    }
    
    func gameFinished() {
        roomID = nil
        players = [Player]()
        me.gameFinished()
        roundFinished()
    }
}
