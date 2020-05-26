//
//  Round.swift
//  Boomche
//
//  Created by Sara Babaei on 5/18/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class RoundData {
    var drawing: Drawing?
    var paint: [[[CGFloat]]]?
    var chatTableViewDelegates: MessageTableViewDelegates?
    var scoreboardTableViewDelegates: ScoreboardTableViewDelegates?
    
    var painter: Player? {
        didSet {
            painter?.isPainter = true
        }
    }
    
    var wordList = [String]()
    var word: String?
    var wordChose = false
    
    func roundFinished() {
        drawing = nil
        paint = nil
        chatTableViewDelegates = nil
        scoreboardTableViewDelegates = nil
        
        painter = nil
        wordList = [String]()
        word = nil
        wordChose = false
    }
}
