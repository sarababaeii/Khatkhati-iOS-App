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

        if let manager = manager {
            socket = manager.defaultSocket
        }
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
    
    func addHandlers() {
        guard let socket = manager?.defaultSocket else{
            return
        }
        
        socket.on(clientEvent: .connect) { data, ack in
            print("^^^^^ CONNECTED ^^^^^")
            Game.sharedInstance.me.socketID = socket.sid
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
            self.getGameSetting(data: temp["data"] as! [String : Any])
        }
        
        socket.on("start_game") { data, ack in
            print("^^^^^ RECEIVING WORDS ^^^^^^")
            self.getWords(data: data[0] as! [String : Any])
        }
        
        socket.on("lets_play") { data, ack in
            print("^^^^^GAME STARTED^^^^^^")
            self.getStartDrawing(data: data[0] as! [String : Any])
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
    func requestRoomID() {
        socket?.emit("send_generate_key")
    }
    
    func getRoomID(data: [String : Any]) {
        Game.sharedInstance.roomID = (data["key"] as! String)
        Game.sharedInstance.me.isLobbyLeader = true
        
        joinGame()
        
        UIApplication.topViewController()?.showNextPage(identifier: "NewLobbyViewController")
    }
    
    //MARK: Joining Game
    func joinGame() {
        let data = ["room_id" : Game.sharedInstance.roomID, "username" : Game.sharedInstance.me.username]
        socket?.emit("subscribe", data)
    }
    
    func getGameProperties(data: [String : Any]) {
        guard UIApplication.topViewController()?.restorationIdentifier == "NewLobbyViewController" else {
            setPlayers(users: data["users"] as! [[String : Any]])
            return
        }
        
        NewLobbyViewController.playersCollectionViewDelegates?.updatePlayers(users: data["users"] as! [[String : Any]])
        
        let settings = data["settings"] as! [String : Any]
//        changeLobbyType(to: settings["type"] as! String)
        changeRoundsNumber(to: settings["round"] as! Int)
    }
    
    func setPlayers(users: [[String : Any]]) {
        for user in users {
            let player = Player(username: user["name"] as! String, colorCode: user["color"] as! Int)
            
            if (user["is_drawer"] as! Int) == 1 {
                player.isPainter = true
                Game.sharedInstance.round.painter = player
            }
            
            Game.sharedInstance.players.append(player)
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
                Game.sharedInstance.round.wordChose = true
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
    
    func getGameSetting(data: [String : Any]) {
        let topViewController = UIApplication.topViewController()
        guard (topViewController?.restorationIdentifier == "NewLobbyViewController" ||
                topViewController?.restorationIdentifier == "GuessingViewController") &&
                Game.sharedInstance.roomID == (data["room_id"] as! String) else {
            return
        }
        
        let property = data["name"] as! String
        let value = data["val"] as! String
        
        switch property {
        case "round":
            changeRoundsNumber(to: Int(value)!)
        case "room-type":
            changeLobbyType(to: value)
        case "color":
            Game.sharedInstance.round.drawing?.brushColor = UIColor(hexString: value)
        case "lineWidth":
            Game.sharedInstance.round.drawing?.brushWidth = CGFloat(Float(value)!)
        default:
            return
        }
    }
    
    func changeRoundsNumber(to roundsNumber: Int) {
        unselectPreviousButton(in: NewLobbyViewController.roundsNumberButtons)
        
        switch roundsNumber {
        case 3:
            NewLobbyViewController.roundsNumberButtons[0].select(isTypeButton: false)
        case 4:
            NewLobbyViewController.roundsNumberButtons[1].select(isTypeButton: false)
        case 5:
            NewLobbyViewController.roundsNumberButtons[2].select(isTypeButton: false)
        case 6:
            NewLobbyViewController.roundsNumberButtons[3].select(isTypeButton: false)
        default:
            NewLobbyViewController.roundsNumberButtons[0].select(isTypeButton: false)
            sendGameSetting(name: "round", value: "3")
        }
    }
    
    func changeLobbyType(to type: String) {
        unselectPreviousButton(in: NewLobbyViewController.lobbyTypeButtons)
        
        switch type {
        case "private":
            NewLobbyViewController.lobbyTypeButtons[0].select(isTypeButton: true)
        case "public":
            NewLobbyViewController.lobbyTypeButtons[1].select(isTypeButton: true)
        default:
            NewLobbyViewController.lobbyTypeButtons[0].select(isTypeButton: true)
            sendGameSetting(name: "room-type", value: "public")
        }
    }
    
    func unselectPreviousButton(in array: [CustomButton]) {
        for button in array {
            if button.isSelected() {
                button.unselect()
            }
        }
    }
    
    //MARK: Starting Game
    func sendStartGame() {
        socket?.emit("start_game_on", Game.sharedInstance.roomID!)
    }
    
    func getStartDrawing(data: [String : Any]) {
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
        Game.sharedInstance.round.wordChose = true
        Game.sharedInstance.round.word = word
    }
    
    //MARK: Choosing word
    func sendWord(word: String) {
        if let roomID = Game.sharedInstance.roomID {
            let data = ["room_id": roomID, "word": word]
            socket?.emit("lets_play_on", data)
        }
    }
    
    func getWords(data: [String : Any]) {
        Game.sharedInstance.roundFinished()
        
        Game.sharedInstance.round.painter = Game.sharedInstance.players.first(where: {$0.username == data["username"] as! String}) //socketID
        Game.sharedInstance.round.painter?.isPainter = true
        
        let viewController = UIApplication.topViewController()
        
        if Game.sharedInstance.me.isPainter {
            Game.sharedInstance.me.hasGuessed = true
            Game.sharedInstance.round.wordList = (data["words"] as? [String])!
            viewController?.showNextPage(identifier: "DrawingViewController")
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
        let data = ["room_id": Game.sharedInstance.roomID!, "text": message, "username": Game.sharedInstance.me.username, "socket_id": Game.sharedInstance.me.socketID]
        socket?.emit("chat", data)
    }
    
    func receiveMessage(data: [String : Any]) {
        guard let sender = Game.sharedInstance.players.first(where: {$0.username == data["username"] as! String}) else { //TODO: socketID
            return
        }
        var message: Message
        
        if (data["correct"] as! Int) == 1 && !sender.hasGuessed{
            message = receiveAnswer(sender: sender)
         } else {
             message = receiveNormalText(sender: sender, text: data["text"] as! String)
         }
        
        Game.sharedInstance.round.chatTableViewDelegates?.insertMessage(message)
    }
    
    func receiveAnswer(sender: Player) -> Message {
        let message = Message(sender: sender, content: "درست حدس زد!")
        
        sender.hasGuessed = true //bug
        if Game.sharedInstance.me.socketID == sender.socketID {
            Game.sharedInstance.me.hasGuessed = true
        }
        
        return message
    }
    
    func receiveNormalText(sender: Player, text: String) -> Message {
        return Message(sender: sender, content: text)
    }
    
    //MARK: Ending Game
    func endOfRound(data: [String : Any]) {
        let temp = data["data"] as! [String : Any]
        ScoreboardTableViewDelegates.initialScoreboard(users: temp["users"] as! [[String : Any]])
        
        if (data["endOfGame"] as! Int) == 1 {
            UIApplication.topViewController()?.showNextPage(identifier: "EndGameViewController")
        } else {
            UIApplication.topViewController()?.showNextPage(identifier: "ScoresViewController")
        }
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
