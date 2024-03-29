//
//  Player.swift
//  Boomche
//
//  Created by Sara Babaei on 4/17/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation

class Player {
    var username: String
    var socketID: String
    
    var colorCode: Int {
        didSet {
            switch colorCode {
            case 1:
                color = Colors.red.playerColor!
            case 2:
                color = Colors.green.playerColor!
            case 3:
                color = Colors.orange.playerColor!
            case 4:
                color = Colors.purple.playerColor!
            case 5:
                color = Colors.darkBlue.playerColor!
            case 6:
                color = Colors.lightBlue.playerColor!
            default:
                color = Colors.red.playerColor!
            }
        }
    }
    var color: Color
    
    var totalScore: Int
    var currentScore: Int
    
    var isLobbyLeader = false
    var hasGuessed = false
    
    var isPainter = false
    var isFirstGuesser = false
    
    init(socketID: String, username: String, colorCode: Int, totalScore: Double, currentScore: Double) {
        self.socketID = socketID
        self.username = username
        self.colorCode = colorCode
        switch colorCode {
        case 1:
            color = Colors.red.playerColor!
        case 2:
            color = Colors.green.playerColor!
        case 3:
            color = Colors.orange.playerColor!
        case 4:
            color = Colors.purple.playerColor!
        case 5:
            color = Colors.darkBlue.playerColor!
        case 6:
            color = Colors.lightBlue.playerColor!
        default:
            color = Colors.red.playerColor!
        }
        self.totalScore = Int(totalScore)
        self.currentScore = Int(currentScore)
    }
    
    convenience init(socketID: String, username: String, colorCode: Int) {
        self.init(socketID: socketID, username: username, colorCode: colorCode, totalScore: 0, currentScore: 0)
    }
    
    convenience init(socketID: String, username: String) {
        self.init(socketID: socketID, username: username, colorCode: 1)
    }
    
    func isMe() -> Bool {
        return self.socketID == Game.sharedInstance.me.socketID
    }
    
    func roundFinished() {
        totalScore += currentScore
        currentScore = 0
        hasGuessed = false
        isPainter = false
        isFirstGuesser = false
    }
    
    func gameFinished() {
        roundFinished()
        
        colorCode = 1
        totalScore = 0
        isLobbyLeader = false
    }
}
