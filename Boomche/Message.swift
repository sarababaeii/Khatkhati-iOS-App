//
//  Message.swift
//  Boomche
//
//  Created by Sara Babaei on 4/9/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation

class Message {
    var username: String
    var content: String
    var senderHasGuessed = false
    
    init(username: String, content: String) {
        self.username = username
        self.content = content
    }
}
