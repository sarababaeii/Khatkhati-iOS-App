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

    var users = [String]()
    var draw = [String : Any]()
    var words = [String : Any]()
    var play = [String : String]()
    
    
    //MARK: Connecting
    func establishConnection() {
        guard let socket = manager?.defaultSocket else{
            return
        }

        socket.connect()
    }
    
    func closeConnection() {
        guard let socket = manager?.defaultSocket else{
            return
        }
        
        socket.disconnect()
    }
    
    func joinGame(roomID: String, username: String) {
        let data = ["room_id" : roomID, "username" : username]
        socket?.emit("subscribe", data)
        
        addHandlers()
    }
    
    func getPlayers() {
        print("hereeeee")
        for user in users {
            print(user)
        }
        
    }
    
    func addHandlers() {
        socket?.on("players_list") { data, ack in
            let kuft = data[0] as! [String : Any]
            self.users = kuft["users"] as! [String]
            return
        }
    }
    
    //MARK: Drawing
    func sendDrawing(roomID: String, state: String, point: [CGFloat]) {
        let data = ["room": roomID, "state": state, "point": point] as [String : Any]
        //color and brush size not defined
        socket?.emit("send_message", data)
    }
    
    func receiveDrawing(state: String, point: [CGFloat]) {
//        switch state {
//        case "start":
////
//        case "moving":
//
//        case "end":
//
//        default:
//            <#code#>
//        }
    }
    
    //MARK: Choosing word
    func sendWord(word: String) {
        if let roomID = GameConstants.roomID {
            let data = ["room_id": roomID, "word": word]
            socket?.emit("lets_play_on", data)
        }
    }
    
    func receiveWords() {
        
    }
    
    //MARK: Chatting
    func sendMessage(message: String) {
        if let roomID = GameConstants.roomID {
            let data = ["room_id": roomID, "text": message, "username": GameConstants.username!]
            socket?.emit("chat", data)
        }
    }
    
    func receiveMessage() {

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
    
    private func configure() {
        guard let url = URL(string: "http://thechain.ir:3000") else {
            return
        }

        manager = SocketManager(socketURL: url, config: [.log(true), .compress])

        guard let manager = manager else {
            return
        }

        socket = manager.defaultSocket
    }
    
    override init() {
        super.init()

        configure()
    }
}
