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
    }
    
    func getPlayer() {
        print("1 more step pleeeease")
        
        socket?.on("players_list", callback: { (data, ack) in
            print("hereeee")
            if let dict = data[0] as? [String : Any] {
                print(dict["users"] as Any)
          }
        })
    }
    
    //MARK: Drawing
    func sendDrawing(roomID: String, state: String, point: [CGFloat]) {
        let data = ["room": roomID, "state": state, "point": point] as [String : Any]
        //color and brush size not defined
        socket?.emit("send_message", data)
    }
    
    func receiveDrawing() {
        
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
