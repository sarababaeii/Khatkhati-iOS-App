//
//  SocketIOManager.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/28/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import UIKit
import SocketIO

protocol MessageDelegate {
    func showMessage(_ message: Message)
}

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()

     var manager: SocketManager?
     var socket: SocketIOClient?

    var messageDelegate: MessageDelegate?
    
    var users = [String]()
    var words = [String]()
    var nextViewControllerIdentifier = ""
    
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
        
//        addHandlers()
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
    
    //MARK: Creating Lobby
    func creatLobby() {
        socket?.emit("send_generate_key")
    }
    
    //MARK: Joining Game
    func joinGame() {
        let data = ["room_id" : GameConstants.roomID, "username" : GameConstants.username]
        socket?.emit("subscribe", data)
    }
    
    //MARK: Game Settings
    func gameSetting(name: String, value: Int) {
        let data = ["name" : name, "val" : value, "room_id" : GameConstants.roomID!] as [String : Any]
        socket?.emit("send_room_settings", data)
    }
    
    //MARK: Starting Game
    func startGame() {
//        let data = ["room_id" : GameConstants.roomID]
        socket?.emit("start_game_on", GameConstants.roomID!)
    }
    
    func playAgain() {
        let data = ["room_id" : GameConstants.roomID]
        socket?.emit("send_play_again", data)
    }
    
    //MARK: Choosing word
    func sendWord(word: String) {
        print(">>>>>SENDING WORD<<<<<")
        if let roomID = GameConstants.roomID {
            let data = ["room_id": roomID, "word": word]
            socket?.emit("lets_play_on", data)
        }
    }
    
    //MARK: Drawing
    func sendDrawing(roomID: String, state: String, point: [CGFloat]) {
        print(">>>>>SENDING DRAWING<<<<<")
        let data = ["room": roomID, "state": state, "point": point] as [String : Any]
        //color and brush size not defined
        socket?.emit("send_message", data)
    }
    
    //MARK: Chatting
    func sendMessage(message: String) {
        print(">>>>>SENDING MESSAGE<<<<<")
        if let roomID = GameConstants.roomID {
            let data = ["room_id": roomID, "text": message, "username": GameConstants.username]
            socket?.emit("chat", data)
        }
    }
//    func receiveWords() -> [String] {
//        return words
//    }
    
//    func receiveMessage(_ message: Message) {
//        messageDelegate?.showMessage(message)
//    }
}
