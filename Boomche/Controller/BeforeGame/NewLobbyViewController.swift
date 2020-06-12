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
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var shareView: UIButton!
   
    @IBOutlet weak var roundsNumberLabel: UILabel!
    @IBOutlet weak var roundsNumberButton6: CustomButton!
    @IBOutlet weak var roundsNumberButton5: CustomButton!
    @IBOutlet weak var roundsNumberButton4: CustomButton!
    @IBOutlet weak var roundsNumberButton3: CustomButton!
    
    @IBOutlet weak var lobbyTypeLabel: UILabel!
    @IBOutlet weak var privateLobbyTypeButton: CustomButton!
    @IBOutlet weak var publicLobbyTypeButton: CustomButton!
    
    @IBOutlet weak var playersCollectionView: UICollectionView!
    
    @IBOutlet weak var startGameButton: UIButton!
    
    static var lobbyTypeButtons = [CustomButton]()
    static var roundsNumberButtons = [CustomButton]()
    
    static var playersCollectionViewDelegates: PlayersCollectionViewDelegates?
    
    //MARK: Sharing Lobby Name
    @IBAction func copyLobbyName(_ sender: Any) {
        if let lobbyName = lobbyNameTextField.fetchInput() {
            UIPasteboard.general.string = lobbyName
            lobbyNameTextField.resignFirstResponder()
        }
    }
    
    @IBAction func shareLobbyName(_ sender: Any) {
        if let lobbyName = lobbyNameTextField.fetchInput() {
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
    
    //MARK: Game Properties
    @IBAction func changeRoundsNumber(_ sender: Any) {
        let roundsNumber: Int
        switch (sender as! UIButton).titleLabel!.text! {
        case "۳":
            roundsNumber = 3
        case "۴":
            roundsNumber = 4
        case "۵":
            roundsNumber = 5
        case "۶":
            roundsNumber = 6
        default:
            roundsNumber = 6
        }
        SocketIOManager.sharedInstance.sendGameSetting(name: "round", value: String(roundsNumber))
    }
    
    @IBAction func changeLobbyType(_ sender: Any) {       
        let type: String
        switch (sender as! UIButton).titleLabel!.text! {
        case "خودمونی":
            type = "private"
        case "عمومی":
            type = "public"
        default:
            type = "public"
        }
        SocketIOManager.sharedInstance.sendGameSetting(name: "room-type", value: type)
    }
    
    //MARK: Starting Game
    @IBAction func startGame(_ sender: Any) {
        SocketIOManager.sharedInstance.sendStartGame()
    }
    
    //MARK: Initializing
    func initializeVariables() {
        NewLobbyViewController.roundsNumberButtons = [roundsNumberButton3, roundsNumberButton4, roundsNumberButton5, roundsNumberButton6]
        NewLobbyViewController.lobbyTypeButtons = [privateLobbyTypeButton, publicLobbyTypeButton]
        
        NewLobbyViewController.playersCollectionViewDelegates = PlayersCollectionViewDelegates(playersCollectionView: playersCollectionView)
        
        playersCollectionView.delegate = NewLobbyViewController.playersCollectionViewDelegates
        playersCollectionView.dataSource = NewLobbyViewController.playersCollectionViewDelegates
    }
    
    func clearVariables() {
        NewLobbyViewController.roundsNumberButtons.removeAll()
        NewLobbyViewController.lobbyTypeButtons.removeAll()
        NewLobbyViewController.playersCollectionViewDelegates = nil
    }
    
    //MARK: UI Handling
    func setUIComponentAttributes() {
        lobbyNameTextField.text = Game.sharedInstance.roomID
        
        if !Game.sharedInstance.me.isLobbyLeader {
            for button in NewLobbyViewController.roundsNumberButtons {
                button.isEnabled = false
            }
            for button in NewLobbyViewController.lobbyTypeButtons {
                button.isEnabled = false
            }
            startGameButton.isEnabled = false
        }
    }
    
    func configure() {
        initializeVariables()
        
        setUIComponentAttributes()
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
       // Do any additional setup after loading the view.
        
        configure()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        clearVariables()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setGradientSizes()
    }
}
