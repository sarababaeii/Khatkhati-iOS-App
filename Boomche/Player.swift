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
    var color: Color
    var totalScore: Int
    var currentScore: Int
    
    var isPainter = false
    var isFirstGuesser = false
    
    init(username: String, color: Color) {
        self.username = username
        self.color = color
        self.totalScore = 0
        self.currentScore = 0
    }
    
    convenience init(username: String, color: Color, totalScore: Double, currentScore: Double) {
        self.init(username: username, color: color)
        self.totalScore = Int(totalScore)
        self.currentScore = Int(currentScore)
    }
}
