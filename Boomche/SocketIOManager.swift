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
        guard let url = URL(string: "http://37.221.114.125:3000") else {
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
    
    //MARK: Adding Handlers
    func addHandlers() {
        socket?.on("players_list") { data, ack in
            print("^^^^^RECEIVING PLAYERS^^^^^^")
            
            let temp = data[0] as! [String : Any]
            self.users = temp["users"] as! [String]
        }
        
//        socket?.on("conversation_private") { data, ack in
//            print("^^^^^RECEIVING DRAW^^^^^^")
//            
//            var temp = data[0] as! [String : Any]
//            temp = temp["data"] as! [String : Any]
//            
//            if let roomID = GameConstants.roomID {
//                if roomID == temp["room"] as! String {
//                    self.receiveDrawing(state: temp["state"] as! String, point: temp["point"] as! [CGFloat])
//                }
//            }
//        }
        
        //TODO: is it correct?!
        // vaghti in umad be loading elam kone ke bere safhe bad
        socket?.on("start_game") { data, ack in
            print("^^^^^RECEIVING WORDS^^^^^^")
            
            let temp = data[0] as! [String : Any]
            
            self.words = temp["words"] as! [String]
            self.determiningNextPage(username: temp["username"] as! String)
            
//            if let username = GameConstants.username,
//                username == temp["username"] as! String {
//                    self.words = temp["words"] as! [String]
//            }
        }
        
        socket?.on("chat_and_guess") {data, ack in
            print("^^^^^RECEIVING MESSAGE^^^^^^")
            
            let temp = data[0] as! [String : Any]
            
            let message = Message(username: temp["username"] as! String, content: temp["text"] as! String)
            
            print("@@@@@@ \(message.username): \(message.content)")
            
            self.receiveMessage(message)
        }
    }
    
    func determiningNextPage(username: String) {
        if GameConstants.username == username {
            nextViewControllerIdentifier = "DrawingViewController"
        } else {
            nextViewControllerIdentifier = "GuessingViewController"
        }
        
        if let topController = UIApplication.topViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: nextViewControllerIdentifier) as UIViewController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .coverVertical
            topController.present(controller, animated: true, completion: nil)
        }
    }
    
    //MARK: Joining Game
    func joinGame(roomID: String, username: String) {
        let data = ["room_id" : roomID, "username" : username]
        socket?.emit("subscribe", data)
    }
    
    func getPlayers() {
        for user in users {
            print(user)
        }
    }
    
    //MARK: Starting Game
    func startGame(roomID: String) {
        let data = ["room_id" : roomID]
        socket?.emit("start_game_on", data)
    }
    
    //MARK: Drawing
    func sendDrawing(roomID: String, state: String, point: [CGFloat]) {
        print(">>>>>SENDING DRAWING<<<<<")
        let data = ["room": roomID, "state": state, "point": point] as [String : Any]
        //color and brush size not defined
        socket?.emit("send_message", data)
    }
    
//    func receiveDrawing(state: String, point: [CGFloat]) {
//        switch state {
//        case "start":
////            print("!!!!!DRAWING started!!!!!")
////            GuessingViewController.drawing?.touchesBegan(CGPoint(x: point[0], y: point[1]))
//            drawDelegate?.begin(CGPoint(x: point[0], y: point[1]))
////            GuessingViewController.sharedInstance!.begin()
//        case "moving":
////            print("!!!!!DRAWING moved!!!!!")
////            GuessingViewController.drawing?.touchesMoved(CGPoint(x: point[0], y: point[1]))
//            drawDelegate?.move(CGPoint(x: point[0], y: point[1]))
//        case "end":
////            print("!!!!!DRAWING ended!!!!!")
////            GuessingViewController.drawing?.touchesEnded()
//            drawDelegate?.end()
//        default:
//            print("Error in receiving draw")
//        }
//    }
    
    //MARK: Choosing word
    func sendWord(word: String) {
        print(">>>>>SENDING WORD<<<<<")
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
        print(">>>>>SENDING MESSAGE<<<<<")
        if let roomID = GameConstants.roomID {
            let data = ["room_id": roomID, "text": message, "username": GameConstants.username]
            socket?.emit("chat", data)
        }
    }
    
    func receiveMessage(_ message: Message) {
        messageDelegate?.showMessage(message)
    }
}
