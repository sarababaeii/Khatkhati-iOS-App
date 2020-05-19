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
    var socketID: String?
    
    var colorCode: Int
    var color: Color
    
    var totalScore: Int
    var currentScore: Int
    
    var isLobbyLeader = false
    var hasGuessed = false
    
    var isPainter = false
    var isFirstGuesser = false
    
    init(username: String, colorCode: Int, totalScore: Double, currentScore: Double) {
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
    
    convenience init(username: String, colorCode: Int) {
        self.init(username: username, colorCode: colorCode, totalScore: 0, currentScore: 0)
    }
    
    convenience init(username: String) {
        self.init(username: username, colorCode: 1)
    }
    
    func roundFinished() {
        currentScore = 0 //?!
        hasGuessed = false
        isPainter = false
        isFirstGuesser = false
    }
    
    func gameFinished() {
        colorCode = 1
        totalScore = 0
        isLobbyLeader = false
        
        roundFinished()
    }
}
