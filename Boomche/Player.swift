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
    
    init(username: String, color: Color, totalScore: Int, currentScore: Int) {
        self.username = username
        self.color = color
        self.totalScore = totalScore
        self.currentScore = currentScore
    }
}
