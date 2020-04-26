//
//  SocketIOManager.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/28/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()

    var manager: SocketManager?
    var socket: SocketIOClient?
    
//    var socketID: String?
    
    //MARK: Initializing
    override init() {
        super.init()

        configure()
    }
    
    private func configure() {
        guard let url = URL(string: "http://boomche.ir:3000") else {
            return
        }

        manager = SocketManager(socketURL: url, config: [.log(true), .compress])

        guard let manager = manager else {
            return
        }

        socket = manager.defaultSocket
    }
    
    //MARK: Connection Management
    func establishConnection() {
        guard let socket = manager?.defaultSocket else{
            return
        }
        socket.connect()
        
        addHandlers()
    }
    
    func closeConnection() {
        guard let socket = manager?.defaultSocket else{
            return
        }
        socket.disconnect()
    }
    
    func shareStatus() {
        let status = socket?.status
        
        switch status {
        case .connected:
            print("Yaaaaay    Connected!!!!")
        case .connecting:
            print("Good    is Connecting....")
        case .notConnected:
            print("Oops :(    not Connected________")
        case .disconnected:
            print("Shit    disconnected ^^^^^^^")
        default:
            print("Default")
        }
    }
    
    func addHandlers() {
        SocketIOManager.sharedInstance.socket?.on("get_generate_key") { data, ack in
            print("^^^^^ RECEIVING ROOM_ID ^^^^^^")
            self.getRoomID(data: data[0] as! [String : Any])
        }
        
        SocketIOManager.sharedInstance.socket?.on("get_room_settings") { data, ack in
            print("^^^^^RECEIVING ROOM_DATA^^^^^^")
            let temp = data[0] as! [String : Any]
            self.getGameSettings(data: temp["data"] as! [String : Any])
        }
        
        SocketIOManager.sharedInstance.socket?.on("start_game") { data, ack in
            print("^^^^^ RECEIVING WORDS ^^^^^^")
            self.getWords(data: data[0] as! [String : Any])
        }
        
        SocketIOManager.sharedInstance.socket?.on("lets_play") { data, ack in
            print("^^^^^GAME STARTED^^^^^^")
            self.getStartGame()
        }
        
        SocketIOManager.sharedInstance.socket?.on("end_of_the_round") { data, ack in
            print("^^^^^ RECEIVING ROUND DATA ^^^^^^")
            self.endOfRound(data: data[0] as! [String : Any])
        }
    }
    
    //MARK: Creating Lobby
    func creatLobby() {
        socket?.emit("send_generate_key")
    }
    
    func getRoomID(data: [String : Any]) {
        guard UIApplication.topViewController()?.restorationIdentifier == "HomeViewController" else {
            return
        }
        
        Game.sharedInstance.roomID = (data["key"] as! String)
        joinGame()
                                                     
        Game.sharedInstance.isLobbyLeader = true
        
        UIApplication.topViewController()?.showNextPage(identifier: "NewLobbyViewController")
    }
    
    //MARK: Joining Game
    func joinGame() {
        let data = ["room_id" : Game.sharedInstance.roomID, "username" : Game.sharedInstance.username]
        socket?.emit("subscribe", data)
    }
    
    //MARK: Game Settings
    func sendGameSetting(name: String, value: String) {
        let data = ["name" : name, "val" : value, "room_id" : Game.sharedInstance.roomID!] as [String : Any]
        socket?.emit("send_room_settings", data)
    }
    
    func getGameSettings(data: [String : Any]) {
        guard UIApplication.topViewController()?.restorationIdentifier == "NewLobbyViewController" &&
            Game.sharedInstance.roomID == (data["room_id"] as! String) else {
            return
        }
        
        let value = data["val"] as! String
        let property = data["name"] as! String
        
        switch property {
        case "round":
            NewLobbyViewController.setButtonTitle(button: (NewLobbyViewController.roundsButton)!, title: value.convertEnglishNumToPersianNum())
//            case "time":
        default:
            return
        }
    }
    
    //MARK: Starting Game
    func sendStartGame() {
        socket?.emit("start_game_on", Game.sharedInstance.roomID!)
    }
    
    func getStartGame() {
        guard UIApplication.topViewController()?.restorationIdentifier == "ChoosingWordViewController" ||
           UIApplication.topViewController()?.restorationIdentifier == "WaitingViewController" else {
            return
        }
        
        UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Ending Game
    func endOfRound(data: [String : Any]) {
        guard UIApplication.topViewController()?.restorationIdentifier == "DrawingViewController" ||
           UIApplication.topViewController()?.restorationIdentifier == "GuessingViewController" else {
            return
        }
        
        if (data["endOfGame"] as! Int) == 1 {
            ScoresViewController.isLastRound = true
        }
        
        var temp = data["data"] as! [String : Any]
        ScoresViewController.users = temp["users"] as! [[String : Any]]

        temp = temp["room"] as! [String : Any]
        ScoresViewController.word = (temp["word"] as? String)!
        
        UIApplication.topViewController()?.showNextPage(identifier: "ScoresViewController")
    }
    
    func playAgain() {
        socket?.emit("send_play_again", Game.sharedInstance.roomID!)
    }
    
    //MARK: Choosing word
    func sendWord(word: String) {
        if let roomID = Game.sharedInstance.roomID {
            let data = ["room_id": roomID, "word": word]
            socket?.emit("lets_play_on", data)
        }
    }
    
    func getWords(data: [String : Any]) {
        //TODO: guard
        let viewController = UIApplication.topViewController()
        
        //TODO: Should get socket id
        if (data["username"] as! String) == Game.sharedInstance.username {
            ChoosingWordViewController.words = data["words"] as? [String]
            viewController?.showNextPage(identifier: "DrawingViewController")
        } else {
            WaitingViewController.chooserName = data["username"] as! String
            viewController?.showNextPage(identifier: "GuessingViewController")
        }
    }
    
    //MARK: Drawing
    func sendDrawing(state: String, point: [CGFloat]) {
        let data = ["room": Game.sharedInstance.roomID!, "state": state, "point": point] as [String : Any]
        //color and brush size not defined
        socket?.emit("send_message", data)
    }
    
    //MARK: Chatting
    func sendMessage(message: String) {
        let data = ["room_id": Game.sharedInstance.roomID!, "text": message, "username": Game.sharedInstance.username]
        socket?.emit("chat", data)
    }
}
