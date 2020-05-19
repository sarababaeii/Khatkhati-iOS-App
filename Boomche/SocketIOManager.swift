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
                                                     
        Game.sharedInstance.me.isLobbyLeader = true
        
        UIApplication.topViewController()?.showNextPage(identifier: "NewLobbyViewController")
    }
    
    //MARK: Joining Game
    func joinGame() {
        let data = ["room_id" : Game.sharedInstance.roomID, "username" : Game.sharedInstance.me.username]
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
        
        changeRoundsNumber(to: String(round).convertEnglishNumToPersianNum())
    }
    
    func setPainter(users: [[String : Any]]) {
        for user in users {
            if (user["is_drawer"] as! Int) == 1 {
                Game.sharedInstance.round.painter = Game.sharedInstance.getPlayerWith(username: user["name"] as! String)
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
    
    func getGameSettings(data: [String : Any]) {
        guard (UIApplication.topViewController()?.restorationIdentifier == "NewLobbyViewController" ||
                UIApplication.topViewController()?.restorationIdentifier == "GuessingViewController") &&
            Game.sharedInstance.roomID == (data["room_id"] as! String) else {
            return
        }
        
        let property = data["name"] as! String
        let value = data["val"] as! String
        
        switch property {
        case "round":
            changeRoundsNumber(to: value.convertEnglishNumToPersianNum())
        case "room-type":
            let type: String
            switch value {
            case "private":
                type = "خودمونی"
            case "public":
                type = "عمومی"
            default:
                type = "خودمونی"
            }
            changeLobbyType(to: type)
        case "color":
            Game.sharedInstance.round.drawing?.brushColor = UIColor(hexString: value)
        case "lineWidth":
            Game.sharedInstance.round.drawing?.brushWidth = CGFloat(Float(value)!)
        default:
            return
        }
    }
    
    func changeRoundsNumber(to roundsNumber: String) {
        for button in NewLobbyViewController.roundsNumberButtons {
            if isSelected(button: button) {
                unselectButton(button: button)
            }
        }
        
        let button: CustomButton
        switch roundsNumber {
        case "۳":
            button = NewLobbyViewController.roundsNumberButtons[0]
        case "۴":
            button = NewLobbyViewController.roundsNumberButtons[1]
        case "۵":
            button = NewLobbyViewController.roundsNumberButtons[2]
        case "۶":
            button = NewLobbyViewController.roundsNumberButtons[3]
        default:
            button = NewLobbyViewController.roundsNumberButtons[0]
        }
        
        selectButton(button: button, isTypeButton: false)
    }
    
    func changeLobbyType(to type: String) {
        for button in NewLobbyViewController.lobbyTypeButtons {
            if isSelected(button: button) {
                unselectButton(button: button)
            }
        }
        
        let button: CustomButton
        switch type {
        case "خودمونی":
            button = NewLobbyViewController.lobbyTypeButtons[0]
        case "عمومی":
            button = NewLobbyViewController.lobbyTypeButtons[1]
        default:
            button = NewLobbyViewController.lobbyTypeButtons[0]
        }
        selectButton(button: button, isTypeButton: true)
    }
    
    func selectButton(button: CustomButton, isTypeButton: Bool) {
        button.setTitleColor(Colors.white.componentColor?.lightBackground, for: .normal)
        button.isEnabled = false
        if isTypeButton {
            button.lightGradientColor = Colors.blue.componentColor!.lightBackground
            button.darkGradientColor = Colors.blue.componentColor!.darkBackground!
        } else {
            button.lightGradientColor = Colors.yellow.componentColor!.lightBackground
            button.darkGradientColor = Colors.yellow.componentColor!.darkBackground!
        }
    }
    
    func unselectButton(button: CustomButton) {
        button.removeGradient()
        button.setTitleColor(Colors.dusk.componentColor?.lightBackground, for: .normal)
        if Game.sharedInstance.me.isLobbyLeader {
            button.isEnabled = true
        }
    }
    
    func isSelected(button: UIButton) -> Bool {
        if button.titleLabel?.textColor == Colors.white.componentColor?.lightBackground {
            return true
        }
        return false
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
        Game.sharedInstance.round.painter = Game.sharedInstance.getPlayerWith(username: data["username"] as! String)
        
        let viewController = UIApplication.topViewController()
        
        if (data["socket_id"] as! String) == Game.sharedInstance.me.socketID {
            Game.sharedInstance.round.wordList = (data["words"] as? [String])!
            viewController?.showNextPage(identifier: "DrawingViewController")
            Game.sharedInstance.me.hasGuessed = true
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
        guard let sender = Game.sharedInstance.getPlayerWith(username: data["username"] as! String) else { //TODO: socketID
            return
        }
        var message: Message
        
        if (data["correct"] as! Int) == 1 &&  !sender.hasGuessed{
            message = receiveAnswer(sender: sender)
         } else {
             message = receiveNormalText(sender: sender, text: data["text"] as! String)
         }
        
//        switch UIApplication.topViewController()?.restorationIdentifier {
        Game.sharedInstance.round.chatTableViewDelegates?.insertMessage(message)
//        case "DrawingViewController":
//
//        case "GuessingViewController" :
//            GuessingViewController.chatTableViewDelegates?.insertMessage(message)
//        default:
//            return
//        }
    }
    
    func receiveAnswer(sender: Player) -> Message {
        let message = Message(sender: sender, content: "درست حدس زد!")
        
//        Game.sharedInstance.round.personsHaveGuessed.append(senderID)
        sender.hasGuessed = true
        if Game.sharedInstance.me.socketID == sender.socketID { //TODO: be more clear
            Game.sharedInstance.me.hasGuessed = true
        }
        
        return message
    }
    
    func receiveNormalText(sender: Player, text: String) -> Message {
        let message = Message(sender: sender, content: text)
        
        return message
    }
    
    //MARK: Ending Game
    func endOfRound(data: [String : Any]) {
        Game.sharedInstance.roundFinished()
        
        if (data["endOfGame"] as! Int) == 1 {
            ScoresViewController.isLastRound = true
        }
        
        var temp = data["data"] as! [String : Any]
        ScoresViewController.users = temp["users"] as! [[String : Any]]

        temp = temp["room"] as! [String : Any]
        Game.sharedInstance.round.word = (temp["word"] as? String)!
        
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


//color = 1;
//"is_drawer" = 0;
//name = "\U0633\U0627\U0631\U0627";
