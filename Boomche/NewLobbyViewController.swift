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
    @IBOutlet weak var roundsNumberButton6: UIButton!
    @IBOutlet weak var roundsNumberButton5: UIButton!
    @IBOutlet weak var roundsNumberButton4: UIButton!
    @IBOutlet weak var roundsNumberButton3: UIButton!
    
    @IBOutlet weak var lobbyTypeLabel: UILabel!
    @IBOutlet weak var privateLobbyTypeButton: UIButton!
    @IBOutlet weak var publicLobbyTypeButton: UIButton!
    
    @IBOutlet weak var playersCollectionView: UICollectionView!
    
    @IBOutlet weak var startGameButton: UIButton!
    
    
    var lobbyTypeButtons = [UIButton]()
    var roundsNumberButtons = [UIButton]()
    
    
    
    static var roundsButton : UIButton?
    static var typeButton : UIButton?
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
        for button in lobbyTypeButtons {
            if isSelected(button: button) {
                unselectButton(button: button)
            }
        }
        selectButton(button: sender as! UIButton, isTypeButton: false)
        SocketIOManager.sharedInstance.sendGameSetting(name: "round", value: String((sender as! UIButton).titleLabel!.text!))
    }
    
    @IBAction func changeLobbyType(_ sender: Any) {
        for button in lobbyTypeButtons {
            if isSelected(button: button) {
                unselectButton(button: button)
            }
        }
        selectButton(button: sender as! UIButton, isTypeButton: true)
        SocketIOManager.sharedInstance.sendGameSetting(name: "room-type", value: String((sender as! UIButton).titleLabel!.text!))
    }
    
    func selectButton(button: UIButton, isTypeButton: Bool) {
        button.titleLabel?.textColor = Colors.white.componentColor?.lightBackground
        button.isEnabled = false
        if isTypeButton {
            button.setAttributes(color: Colors.blue.componentColor!, radius: 15, hasShadow: false)
        } else {
            button.setAttributes(color: Colors.yellow.componentColor!, radius: 20, hasShadow: false)
        }
    }
    
    func unselectButton(button: UIButton) {
        button.layer.backgroundColor = Colors.gray.componentColor?.lightBackground.cgColor
        button.titleLabel?.textColor = Colors.dusk.componentColor?.lightBackground
        button.isEnabled = true
    }
    
    func isSelected(button: UIButton) -> Bool {
        if button.titleLabel?.textColor == Colors.white.componentColor?.lightBackground {
            return true
        }
        return false
    }
    
    static func setButtonTitle(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
    }
    
    //MARK: Starting Game
    @IBAction func startGame(_ sender: Any) {
        SocketIOManager.sharedInstance.sendStartGame()
    }
    
    //MARK: Initializing
    func initializeVariables() {
        roundsNumberButtons = [roundsNumberButton3, roundsNumberButton4, roundsNumberButton5, roundsNumberButton6]
        lobbyTypeButtons = [privateLobbyTypeButton, publicLobbyTypeButton]
        
        
        NewLobbyViewController.roundsButton = roundsNumberButton6
        NewLobbyViewController.typeButton = privateLobbyTypeButton
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
        copyButton.setAttributes(color: Colors.pink.componentColor!, radius: 15, hasShadow: true)
    }
    
    func setLobbyNameTextFieldAttributes() {
        lobbyNameTextField.layer.cornerRadius = 15
        lobbyNameTextField.text = Game.sharedInstance.roomID
    }
    
    func setShareViewAttributes() {
        shareView.setAttributes(color: Colors.green.componentColor!, radius: 20, hasShadow: true)
    }
    
    func setRoundsNumberLabelAttributes() {
        roundsNumberLabel.setCornerRadius(radius: 28)
        roundsNumberLabel.setBackgroundColor(color: Colors.gray.componentColor!)
    }
    
    func setLobbyTypeLabelAttributes() {
        lobbyTypeLabel.setCornerRadius(radius: 28)
        lobbyTypeLabel.setBackgroundColor(color: Colors.gray.componentColor!)
    }
    
    func setRoundsNumberButtonAttributes() {
        roundsNumberButton6.setAttributes(color: Colors.yellow.componentColor!, radius: 20, hasShadow: false)
        
        if !Game.sharedInstance.isLobbyLeader {
            roundsNumberButton6.isEnabled = false
        }
    }
    
    func setLobbyTypeButtonAttributes() {
        privateLobbyTypeButton.setAttributes(color: Colors.blue.componentColor!, radius: 15, hasShadow: false)
       
        if !Game.sharedInstance.isLobbyLeader {
            privateLobbyTypeButton.isEnabled = false
        }
    }
    
    func setStartGameButtonAttributes() {
        startGameButton.setAttributes(color: Colors.blue.componentColor!, radius: 15, hasShadow: false)
        
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
