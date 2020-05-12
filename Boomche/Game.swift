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
    var username = "سارا"
    
    var isLobbyLeader = false
    var hasGuessed = false
    
    //MARK: Game Information
    var roomID: String?
    
    var painter = ""
    var wordList = [String]()
    var word: String?
    var wordChose = false
    var personsHaveGuessed = [String]()
    
    func resetRoom() {
        roomID = nil
        isLobbyLeader = false
        resetRound()
    }
    
    func resetRound() {
        painter = ""
        wordList.removeAll()
        word = nil
        wordChose = false
        hasGuessed = false
        personsHaveGuessed.removeAll()
    }
    
//    static var roundNumber = 3
//    var lobbyType = "Private"
}
        
