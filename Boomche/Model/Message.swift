//
//  Message.swift
//  Boomche
//
//  Created by Sara Babaei on 4/9/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation

class Message {
    var sender: Player
    var content: String
    var isAnswer: Bool
    
    init(sender: Player, content: String, isAnswer: Bool) {
        self.sender = sender
        self.content = content
        self.isAnswer = isAnswer
    }
}
