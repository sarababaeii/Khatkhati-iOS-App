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
    var words = [String]()
    
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
        for user in users {
            print(user)
        }
    }
    
    func addHandlers() {
        socket?.on("players_list") { data, ack in
            print("^^^^^RECEIVING PLAYERS^^^^^^")
            
            let temp = data[0] as! [String : Any]
            self.users = temp["users"] as! [String]
            //return
        }
        
        socket?.on("conversation_private") { data, ack in
            print("^^^^^RECEIVING DRAW^^^^^^")
            
            var temp = data[0] as! [String : Any]
            temp = temp["data"] as! [String : Any]
            
            if let roomID = GameConstants.roomID {
                if roomID == temp["room"] as! String {
                    self.receiveDrawing(state: temp["state"] as! String, point: temp["point"] as! [CGFloat])
                }
            }
            //return
        }
         //TODO: is it correct?!
        socket?.on("start_game") { data, ack in
            print("^^^^^RECEIVING WORDS^^^^^^")
            
            let temp = data[0] as! [String : Any]
            
            if let username = GameConstants.username,
                username == temp["username"] as! String {
                    self.words = temp["words"] as! [String]
            }
            //return
        }
    }
    
    //MARK: Drawing
    func sendDrawing(roomID: String, state: String, point: [CGFloat]) {
        let data = ["room": roomID, "state": state, "point": point] as [String : Any]
        //color and brush size not defined
        socket?.emit("send_message", data)
    }
    
    func receiveDrawing(state: String, point: [CGFloat]) {
        switch state {
        case "start":
            GuessingViewController.drawing?.touchesBegan(CGPoint(x: point[0], y: point[1]))
        case "moving":
            GuessingViewController.drawing?.touchesMoved(CGPoint(x: point[0], y: point[1]))
        case "end":
            GuessingViewController.drawing?.touchesEnded()
        default:
            print("Error in receiving draw")
        }
    }
    
    //MARK: Choosing word
    func sendWord(word: String) {
        if let roomID = GameConstants.roomID {
            let data = ["room_id": roomID, "word": word]
            socket?.emit("lets_play_on", data)
        }
    }
    
    func receiveWords() -> [String] {
        return words
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
    
    func showNextPage(nextViewController: UIViewController) {
//        let preViewController : UIStoryboard = UIStoryboard(name: "UserBoard", bundle:nil)
//        let homeView  = sampleStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        LoadingViewController.presentViewController(nextViewController, animated:true, completion:nil)
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
