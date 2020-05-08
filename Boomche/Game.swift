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
    
    var roomID: String?
    var username = "سارا"
    var isLobbyLeader = false
    
    var hasGuessed = false
//    var painter: String?
    var personsHaveGuessed = [String]()
    
//    static var roundNumber = 3
//    var lobbyType = "Private"
}
        
