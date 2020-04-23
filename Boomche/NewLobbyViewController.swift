//
//  NewLobbyViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class NewLobbyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var lobbyNameTextField: UITextField!
    @IBOutlet weak var copyButton: CustomButton!
    @IBOutlet weak var shareView: CustomButton!
   
    @IBOutlet weak var roundsNumberLabel: CustomLabel!
    @IBOutlet weak var lobbyTypeLabel: CustomLabel!
    
    @IBOutlet weak var roundsNumberButton: CustomButton!
    @IBOutlet weak var lobbyTypeButton: CustomButton!
    
    @IBOutlet weak var playersCollectionView: UICollectionView!
    
    @IBOutlet weak var startGameButton: CustomButton!
    
    var players = [Player]()
    
    //MARK: Socket Management
    func addSocketHandler() {
        SocketIOManager.sharedInstance.socket?.on("init_data") { data, ack in
            print("^^^^^RECEIVING ROOM_DATA^^^^^^")
            
            let temp = data[0] as! [String : Any]
            let users = temp["users"] as! [String]
            self.updatePlayers(users: users)
            
            let settings = temp["settings"] as! [String : Any]
//                let time = settings["time"] as! Int
            let round = settings["round"] as! Int
            
//            GameConstants.roundNumber = round
            self.roundsNumberButton.setTitle(String(round).convertEnglishNumToPersianNum(), for: .normal)
        }
        
        SocketIOManager.sharedInstance.socket?.on("get_room_settings") { data, ack in
            print("^^^^^RECEIVING ROOM_DATA^^^^^^")
            
            var temp = data[0] as! [String : Any]
            temp = temp["data"] as! [String : Any]
            
            if GameConstants.roomID == (temp["room_id"] as! String) {
                let value = temp["val"] as! String
                
                if (temp["name"] as! String) == "round"{
//                    GameConstants.roundNumber = value
                    self.roundsNumberButton.setTitle(value.convertEnglishNumToPersianNum(), for: .normal)
                }
            }
        }
        
        SocketIOManager.sharedInstance.socket?.on("start_game") { data, ack in
            print("^^^^^RECEIVING WORDS^^^^^^")
            
            SocketIOManager.sharedInstance.receiveWords(from: self, data: data[0] as! [String : Any])
        }
    }
    
    //MARK: CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCellID", for: indexPath) as! PlayerCollectionViewCell
        let player = playerDataSource(indexPath: indexPath)
        cell.setAttributes(player: player!)
        return cell
    }
    
    func playerDataSource(indexPath: IndexPath) -> Player? {
        return players[indexPath.row]
    }
    
    func updatePlayers(users: [String]) { //doesn't show
        players.removeAll()
        
        for user in users {
            players.append(Player(username: user, color: Colors.red.playerColor!))
            print("&&&&&&& \(user) &&&&&&")
        }
        players.append(Player(username: "شایان", color: Colors.orange.playerColor!))
        players.append(Player(username: "ارشیا", color: Colors.orange.playerColor!))
    }
    
    func initialPlayers() {
        players.removeAll()
        
        players.append(Player(username: "سارا", color: Colors.orange.playerColor!))
        players.append(Player(username: "ارشیا", color: Colors.orange.playerColor!))
    }
    
    var counter = 3

    func on() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    @objc func updateCounter() {
        if counter > 0 {
            counter -= 1
        }

        if counter == 0 {
            players.append(Player(username: "شایان", color: Colors.orange.playerColor!))
            print("DID IT&&&&&&&")
        }
    }
    
    
    //MARK: Keyboard Management
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lobbyNameTextField.resignFirstResponder()
    }
    
    //MARK: Sharing Lobby Name
    @IBAction func copyLobbyName(_ sender: Any) {
        if let lobbyName = fetchInput() {
            UIPasteboard.general.string = lobbyName
            lobbyNameTextField.resignFirstResponder()
        }
    }
    
    @IBAction func shareLobbyName(_ sender: Any) {
        if let lobbyName = fetchInput() {
            displaySharingOption(lobbyName: lobbyName)
        }
    }
    
    func displaySharingOption(lobbyName: String){
        let note = "بیا بوم‌چه\n"
        let items = [note as Any, lobbyName as Any]

        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
//        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.message]
        present(activityViewController, animated: true, completion: nil)
    }
    
    func fetchInput() -> String? {
        if let caption = lobbyNameTextField.text?.trimmingCharacters(in: .whitespaces) {
            return caption.count > 0 ? caption : nil
        }
        return nil
    }
    
    //MARK: Game Properties
    @IBAction func changeRoundsNumber(_ sender: Any) {
        let currentRoundNumber = roundsNumberButton.titleLabel?.text
        var nextRoundNumberText: String
        var nextRoundNumber: Int
        
        switch currentRoundNumber! {
        case "۳":
            nextRoundNumberText = "۴"
            nextRoundNumber = 4
        case "۴":
            nextRoundNumberText = "۵"
            nextRoundNumber = 5
        case "۵":
            nextRoundNumberText = "۶"
            nextRoundNumber = 6
        case "۶":
            nextRoundNumberText = "۳"
            nextRoundNumber = 3
        default:
            nextRoundNumberText = "۳"
            nextRoundNumber = 3
        }
        
        SocketIOManager.sharedInstance.gameSetting(name: "round", value: String(nextRoundNumber))
        
        roundsNumberButton.setTitle(nextRoundNumberText, for: .normal)
    }
    
    @IBAction func changeLobbyType(_ sender: Any) {
        let currentLobbyType = lobbyTypeButton.titleLabel?.text
        var nextLobbyType: String
        
        switch currentLobbyType! {
        case "عمومی":
            nextLobbyType = "خودمونی"
        case "خودمونی":
            nextLobbyType = "عمومی"
        default:
            nextLobbyType = "عمومی"
        }
        
        //Socket
        lobbyTypeButton.setTitle(nextLobbyType, for: .normal)
    }
    
    //MARK: Starting Game
    @IBAction func startGame(_ sender: Any) {
        SocketIOManager.sharedInstance.startGame()
//        showNextPage(identifier: "LoadingViewController")
    }
    
    //MARK: UI Handling
    func setCopyButtonAttributes() {
        copyButton.setCornerRadius(radius: 20.5)
        copyButton.setShadowColor(color: Colors.pink.componentColor!)
        copyButton.setBackgroundColor(color: Colors.pink.componentColor!)
    }
    
    func setLobbyNameTextFieldAttributes() {
        lobbyNameTextField.layer.cornerRadius = 43
        lobbyNameTextField.text = GameConstants.roomID
    }
    
    func setShareViewAttributes() {
        shareView.setCornerRadius(radius: 20)
        shareView.setShadowColor(color: Colors.green.componentColor!)
        shareView.setBackgroundColor(color: Colors.green.componentColor!)
    }
    
    func setRoundsNumberLabelAttributes() {
        roundsNumberLabel.setCornerRadius(radius: 22.5)
        roundsNumberLabel.setBackgroundColor(color: Colors.gray.componentColor!)
    }
    
    func setLobbyTypeLabelAttributes() {
        lobbyTypeLabel.setCornerRadius(radius: 22.5)
        lobbyTypeLabel.setBackgroundColor(color: Colors.gray.componentColor!)
    }
    
    func setRoundsNumberButtonAttributes() {
        roundsNumberButton.setCornerRadius(radius: 22.5)
        roundsNumberButton.setBackgroundColor(color: Colors.yellow.componentColor!)
    }
    
    func setLobbyTypeButtonAttributes() {
        lobbyTypeButton.setCornerRadius(radius: 22.5)
        lobbyTypeButton.setBackgroundColor(color: Colors.blue.componentColor!)
    }
    
    func setStartGameButtonAttributes() {
        startGameButton.setCornerRadius(radius: 30)
        startGameButton.setShadowColor(color: Colors.blue.componentColor!)
        startGameButton.setBackgroundColor(color: Colors.blue.componentColor!)
    }
    
    func configure() {
        
        playersCollectionView.delegate = self
        playersCollectionView.dataSource = self
        
        initialPlayers()
//        on()
        
        setCopyButtonAttributes()
        setLobbyNameTextFieldAttributes()
        setShareViewAttributes()
        
        setRoundsNumberLabelAttributes()
        setLobbyTypeLabelAttributes()
        
        setRoundsNumberButtonAttributes()
        setLobbyTypeButtonAttributes()
        
        setStartGameButtonAttributes()
        
        addSocketHandler()
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
       // Do any additional setup after loading the view.
        
        configure()

        SocketIOManager.sharedInstance.shareStatus()
    }
}

//TODO: Clickable & unclickable, add insertPlayer function (insertMessage) for dynamic collection view
