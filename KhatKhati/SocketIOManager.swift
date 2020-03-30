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
        
        socket?.on("players_list", callback: {  (data, ack) in
            print("hereeee")
            if let dict = data[0] as? [String : Any] {
                print(dict["users"] as Any)
          }
        })
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
