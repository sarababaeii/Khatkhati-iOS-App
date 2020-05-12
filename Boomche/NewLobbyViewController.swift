//
//  NewLobbyViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class NewLobbyViewController: UIViewController {
    
    @IBOutlet weak var lobbyNameTextField: UITextField!
    @IBOutlet weak var copyButton: CustomButton!
    @IBOutlet weak var shareView: CustomButton!
   
    @IBOutlet weak var roundsNumberLabel: UILabel!
    @IBOutlet weak var lobbyTypeLabel: UILabel!
    
    @IBOutlet weak var roundsNumberButton: CustomButton!
    @IBOutlet weak var lobbyTypeButton: CustomButton!
    
    @IBOutlet weak var playersCollectionView: UICollectionView!
    
    @IBOutlet weak var startGameButton: CustomButton!
    
    static var roundsButton : CustomButton?
    static var typeButton : CustomButton?
    static var playersCollectionViewDelegates: PlayersCollectionViewDelegates?
    
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
        var nextRoundNumber: Int
        
        switch currentRoundNumber! {
        case "۳":
            nextRoundNumber = 4
        case "۴":
            nextRoundNumber = 5
        case "۵":
            nextRoundNumber = 6
        case "۶":
            nextRoundNumber = 3
        default:
            nextRoundNumber = 3
        }
        
        SocketIOManager.sharedInstance.sendGameSetting(name: "round", value: String(nextRoundNumber))
        NewLobbyViewController.setButtonTitle(button: roundsNumberButton, title: String(nextRoundNumber).convertEnglishNumToPersianNum())
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
        
        SocketIOManager.sharedInstance.sendGameSetting(name: "room-type", value: String(nextLobbyType))
        NewLobbyViewController.setButtonTitle(button: lobbyTypeButton, title: nextLobbyType)
    }
    
    static func setButtonTitle(button: CustomButton, title: String) {
        button.setTitle(title, for: .normal)
    }
    
    //MARK: Starting Game
    @IBAction func startGame(_ sender: Any) {
        SocketIOManager.sharedInstance.sendStartGame()
//        showNextPage(identifier: "LoadingViewController")
    }
    
    //MARK: Initializing
    func initializeVariables() {
        NewLobbyViewController.roundsButton = roundsNumberButton
        NewLobbyViewController.typeButton = lobbyTypeButton
        NewLobbyViewController.playersCollectionViewDelegates = PlayersCollectionViewDelegates(playersCollectionView: playersCollectionView)
        
        playersCollectionView.delegate = NewLobbyViewController.playersCollectionViewDelegates
        playersCollectionView.dataSource = NewLobbyViewController.playersCollectionViewDelegates
    }
    
    func clearVariables() {
        NewLobbyViewController.roundsButton = nil
        NewLobbyViewController.typeButton = nil
        NewLobbyViewController.playersCollectionViewDelegates = nil
    }
    
    //MARK: UI Handling
    func setCopyButtonAttributes() {
        copyButton.setCornerRadius(radius: 20.5)
        copyButton.setShadowColor(color: Colors.pink.componentColor!)
        copyButton.setBackgroundColor(color: Colors.pink.componentColor!)
    }
    
    func setLobbyNameTextFieldAttributes() {
        lobbyNameTextField.layer.cornerRadius = 43
        lobbyNameTextField.text = Game.sharedInstance.roomID
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
        
        if !Game.sharedInstance.isLobbyLeader {
            roundsNumberButton.isEnabled = false
        }
    }
    
    func setLobbyTypeButtonAttributes() {
        lobbyTypeButton.setCornerRadius(radius: 22.5)
        lobbyTypeButton.setBackgroundColor(color: Colors.blue.componentColor!)
        
        if !Game.sharedInstance.isLobbyLeader {
            lobbyTypeButton.isEnabled = false
        }
    }
    
    func setStartGameButtonAttributes() {
        startGameButton.setCornerRadius(radius: 30)
        startGameButton.setShadowColor(color: Colors.blue.componentColor!)
        startGameButton.setBackgroundColor(color: Colors.blue.componentColor!)
        
        if !Game.sharedInstance.isLobbyLeader {
            startGameButton.isEnabled = false
        }
    }
    
    func configure() {
        initializeVariables()
        
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
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        clearVariables()
    }
}
