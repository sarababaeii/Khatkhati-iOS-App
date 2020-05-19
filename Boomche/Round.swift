//
//  Round.swift
//  Boomche
//
//  Created by Sara Babaei on 5/18/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation

class RoundData {
    var number = 1
    
    var drawing: Drawing?
    var chatTableViewDelegates: MessageTableViewDelegates?
    
    var painter: Player? {
        didSet {
            painter?.isPainter = true
        }
    }
    
    var wordList = [String]()
    var word: String?
    var wordChose = false
    
    func roundFinished() {
        number += 1
        drawing = nil
        chatTableViewDelegates = nil
        
        painter = nil
        wordList = [String]()
        word = nil
        wordChose = false
    }
    
    func gameFinished() {
        roundFinished()
        number = 1
    }
}
