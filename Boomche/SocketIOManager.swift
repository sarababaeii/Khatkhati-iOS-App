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
    
    var socketID: String?
    
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
        guard let socket = manager?.defaultSocket, socket.status != .connected else{
            return
        }
        socket.connect()
        addHandlers()
    }
    
    func closeConnection() {
        guard let socket = manager?.defaultSocket else{
            return
        }
        socket.removeAllHandlers()
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
        guard let socket = manager?.defaultSocket else{
            return
        }
        
        socket.on(clientEvent: .connect) { data, ack in
            print("^^^^^ CONNECTED ^^^^^")
            self.socketID = socket.sid
        }
        
        socket.on("get_generate_key") { data, ack in
            print("^^^^^ RECEIVING ROOM_ID ^^^^^^")
            self.getRoomID(data: data[0] as! [String : Any])
        }
        
        socket.on("init_data") { data, ack in
            print("^^^^^RECEIVING ROOM_DATA^^^^^^")
            self.getGameProperties(data: data[0] as! [String : Any])
        }
        
        socket.on("find_room_on") {data, ack in
            print("^^^^^ RECEIVING RANDOM GAME ^^^^^^")
            self.receiveRandomGame(data: data[0] as! [String : Any])
        }
        
        socket.on("get_room_settings") { data, ack in
            print("^^^^^RECEIVING ROOM_DATA^^^^^^")
            let temp = data[0] as! [String : Any]
            self.getGameSettings(data: temp["data"] as! [String : Any])
        }
        
        socket.on("start_game") { data, ack in
            print("^^^^^ RECEIVING WORDS ^^^^^^")
            self.getWords(data: data[0] as! [String : Any])
        }
        
        socket.on("lets_play") { data, ack in
            print("^^^^^GAME STARTED^^^^^^")
            self.getStartGame(data: data[0] as! [String : Any])
        }
        
        socket.on("chat_and_guess") {data, ack in
         print("^^^^^RECEIVING MESSAGE^^^^^^")
            self.receiveMessage(data: data[0] as! [String : Any])
        }
        
        socket.on("end_of_the_round") { data, ack in
            print("^^^^^ RECEIVING ROUND DATA ^^^^^^")
            self.endOfRound(data: data[0] as! [String : Any])
        }
    }
    
    //MARK: Creating Lobby
    func creatLobby() {
        socket?.emit("send_generate_key")
    }
    
    func getRoomID(data: [String : Any]) {
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
    
    func getGameProperties(data: [String : Any]) {
        guard UIApplication.topViewController()?.restorationIdentifier == "NewLobbyViewController" else {
            setPainter(users: data["users"] as! [[String : Any]])
            return
        }
        
        NewLobbyViewController.playersCollectionViewDelegates?.updatePlayers(users: data["users"] as! [[String : Any]])
        
        let settings = data["settings"] as! [String : Any]
        //TODO: type
        let round = settings["round"] as! Int
        
        NewLobbyViewController.setButtonTitle(button: (NewLobbyViewController.roundsButton)!, title: String(round).convertEnglishNumToPersianNum())
    }
    
    func setPainter(users: [[String : Any]]) {
        for user in users {
            if (user["is_drawer"] as! Int) == 1 {
                Game.sharedInstance.painter = user["name"] as! String
            }
        }
    }
    
    //MARK: Random Game
    func findGame() {
        socket?.emit("find_room_emit")
    }
    
    func receiveRandomGame(data: [String : Any]) {
        if let roomID = data["hash"] as? String {
            Game.sharedInstance.roomID = roomID
            joinGame()
            //TODO: time
            switch data["state"] as! Int {
            case 0: //server?!
                UIApplication.topViewController()?.showNextPage(identifier: "NewLobbyViewController")
            case 1:
                UIApplication.topViewController()?.showNextPage(identifier: "GuessingViewController")
                Game.sharedInstance.wordChose = true
            case 2:
                UIApplication.topViewController()?.showNextPage(identifier: "ScoresViewController")
                //TODO: score board
            case 3:
                UIApplication.topViewController()?.showNextPage(identifier: "GuessingViewController")
            default:
                UIApplication.topViewController()?.showNextPage(identifier: "LoadingViewController")
            }
        } else {
            print("NO PUBLIC ROOM")
        }
    }
    
    //MARK: Game Settings
    func sendGameSetting(name: String, value: String) {
        let data = ["name" : name, "val" : value, "room_id" : Game.sharedInstance.roomID!] as [String : Any]
        socket?.emit("send_room_settings", data)
    }
    
    func getGameSettings(data: [String : Any]) {
        guard (UIApplication.topViewController()?.restorationIdentifier == "NewLobbyViewController" ||
                UIApplication.topViewController()?.restorationIdentifier == "GuessingViewController") &&
            Game.sharedInstance.roomID == (data["room_id"] as! String) else {
            return
        }
        
        let value = data["val"] as! String
        let property = data["name"] as! String
        
        switch property {
        case "round":
            NewLobbyViewController.setButtonTitle(button: (NewLobbyViewController.roundsButton)!, title: value.convertEnglishNumToPersianNum())
        case "room-type":
            NewLobbyViewController.setButtonTitle(button: (NewLobbyViewController.typeButton)!, title: value)
        case "color":
            GuessingViewController.drawing?.brushColor = UIColor(hexString: value)
        case "lineWidth":
            GuessingViewController.drawing?.brushWidth = CGFloat(Float(value)!)
        default:
            return
        }
    }
    
    //MARK: Starting Game
    func sendStartGame() {
        socket?.emit("start_game_on", Game.sharedInstance.roomID!)
    }
    
    func getStartGame(data: [String : Any]) {
        setWord(word: data["word"] as! String)
        
        let topViewController = UIApplication.topViewController()
        
        if topViewController?.restorationIdentifier == "ChoosingWordViewController" {
            ChoosingWordViewController.parentViewController?.viewDidAppear(false)
        } else if topViewController?.restorationIdentifier == "WaitingViewController" {
            WaitingViewController.parentViewController?.viewDidAppear(false)
        } else {
            return
        }
        
        topViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setWord(word: String) {
        Game.sharedInstance.wordChose = true
        Game.sharedInstance.word = word
    }
    
    //MARK: Choosing word
    func sendWord(word: String) {
        if let roomID = Game.sharedInstance.roomID {
            let data = ["room_id": roomID, "word": word]
            socket?.emit("lets_play_on", data)
        }
    }
    
    func getWords(data: [String : Any]) {
        Game.sharedInstance.painter = data["username"] as! String
        
        let viewController = UIApplication.topViewController()
        
        if (data["socket_id"] as! String) == socketID {
            Game.sharedInstance.wordList = (data["words"] as? [String])!
            viewController?.showNextPage(identifier: "DrawingViewController")
            Game.sharedInstance.hasGuessed = true
        } else {
            viewController?.showNextPage(identifier: "GuessingViewController")
        }
    }
    
    //MARK: Drawing
    func sendDrawing(state: String, point: [CGFloat]) {
        let data = ["room": Game.sharedInstance.roomID!, "state": state, "point": point] as [String : Any]
        socket?.emit("send_message", data)
    }
    
    //MARK: Chatting
    func sendMessage(message: String) {
        let data = ["room_id": Game.sharedInstance.roomID!, "text": message, "username": Game.sharedInstance.username, "socket_id": socketID]
        socket?.emit("chat", data)
    }
    
    func receiveMessage(data: [String : Any]) {
        let senderID = data["socket_id"] as! String
        let senderUsername = data["username"] as! String
        var message: Message
        
        let senderHasGuessed = Game.sharedInstance.personsHaveGuessed.contains(senderID)
        
         if (data["correct"] as! Int) == 1 &&  !senderHasGuessed{
            message = receiveAnswer(senderID: senderID, senderUsername: senderUsername)
         } else {
             message = receiveNormalText(senderID: senderID, senderUsername: senderUsername, text: data["text"] as! String, senderHasGuessed: senderHasGuessed)
         }
        
        switch UIApplication.topViewController()?.restorationIdentifier {
        case "DrawingViewController":
            DrawingViewController.chatTableViewDelegates?.insertMessage(message)
        case "GuessingViewController" :
            GuessingViewController.chatTableViewDelegates?.insertMessage(message)
        default:
            return
        }
    }
    
    func receiveAnswer(senderID: String, senderUsername: String) -> Message {
        let message = Message(username: senderUsername, content: "درست حدس زد!")
        
        Game.sharedInstance.personsHaveGuessed.append(senderID)
        if socketID == senderID {
            Game.sharedInstance.hasGuessed = true
        }
        
        return message
    }
    
    func receiveNormalText(senderID: String, senderUsername: String, text: String, senderHasGuessed: Bool) -> Message {
        let message = Message(username: senderUsername, content: text)
        message.senderHasGuessed = senderHasGuessed
        
        return message
    }
    
    //MARK: Ending Game
    func endOfRound(data: [String : Any]) {
        Game.sharedInstance.resetRound()
        
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
}

// SocketIOClient{/}: Handling event: find_room_on with data: [{
//     hash = abcd;
//     "last_start_time" = 0;
//     name = "my room";
//     restTime = "-1588946596";
//     round = 1;
//     time = 60;
//     "which_round" = 0;
//     word = apple;
// }]
