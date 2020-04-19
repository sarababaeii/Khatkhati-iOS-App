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
    
    func initialPlayers() {
        players.removeAll()
        
        players.append(Player(username: "سارا", color: Colors.red.playerColor!, totalScore: 210, currentScore: 25))
        players.append(Player(username: "Mohammad", color: Colors.green.playerColor!, totalScore: 190, currentScore: 0))
        players.append(Player(username: "عماد", color: Colors.orange.playerColor!, totalScore: 150, currentScore: 10))
        players.append(Player(username: "iamarshiamajidi", color: Colors.purple.playerColor!, totalScore: 130, currentScore: 35))
        players.append(Player(username: "امیر", color: Colors.darkBlue.playerColor!, totalScore: 100, currentScore: 0))
        players.append(Player(username: "سجاد رضایی‌پور", color: Colors.lightBlue.playerColor!, totalScore: 50, currentScore: 5))
        
        players[2].isPainter = true
        players[3].isFirstGuesser = true
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
        let note = "بیا خط‌خطی!\n"
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
        var nextRoundNumber: String
        
        switch currentRoundNumber! {
        case "۳":
            nextRoundNumber = "۴"
        case "۴":
            nextRoundNumber = "۵"
        case "۵":
            nextRoundNumber = "۶"
        case "۶":
            nextRoundNumber = "۳"
        default:
            nextRoundNumber = "۳"
        }
        
        roundsNumberButton.setTitle(nextRoundNumber, for: .normal)
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
        
        lobbyTypeButton.setTitle(nextLobbyType, for: .normal)
    }
    
    //MARK: Starting Game
    @IBAction func startGame(_ sender: Any) {
        presentLoadingViewController()
    }
    
    func presentLoadingViewController() {
        LoadingViewController.parentStoryboardID = "NewLobbyViewController"

        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as UIViewController

        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical

        present(controller, animated: true, completion: nil)
    }
    
    //MARK: UI Handling
    func setCopyButtonAttributes() {
        copyButton.setCornerRadius(radius: 20.5)
        copyButton.setShadowColor(color: Colors.pink.componentColor!)
        copyButton.setBackgroundColor(color: Colors.pink.componentColor!)
    }
    
    func setLobbyNameTextFieldAttributes() {
        lobbyNameTextField.layer.cornerRadius = 43
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
        
        setCopyButtonAttributes()
        setLobbyNameTextFieldAttributes()
        setShareViewAttributes()
        
        setRoundsNumberLabelAttributes()
        setLobbyTypeLabelAttributes()
        
        setRoundsNumberButtonAttributes()
        setLobbyTypeButtonAttributes()
        
        setStartGameButtonAttributes()
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
       // Do any additional setup after loading the view.
        
        configure()

        SocketIOManager.sharedInstance.shareStatus()
    }
}

//TODO: Keyboard management, if lobbyNameTextField was empty?!
