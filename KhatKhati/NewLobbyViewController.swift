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
    @IBOutlet weak var copyButton: CustomButton!
    @IBOutlet weak var nameLabel: CustomLabel!
    @IBOutlet weak var telegramView: CustomButton!
   
    @IBOutlet weak var roundsNumberLabel: CustomLabel!
    @IBOutlet weak var lobbyTypeLabel: CustomLabel!
    
    @IBOutlet weak var roundsNumberButton: CustomButton!
    @IBOutlet weak var lobbyTypeButton: CustomButton!
    
    @IBOutlet weak var startGameButton: CustomButton!
    
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
    
    func setCopyButtonAttributes() {
        copyButton.setCornerRadius(radius: 20)
        copyButton.setShadowColor(color: Colors.pink)
        copyButton.setBackgroundColor(color: Colors.pink)
    }
    
    func setNameLabelAttributes() {
        nameLabel.setCornerRadius(radius: 43)
        nameLabel.setBackgroundColor(color: Colors.gray)
    }
    
    func setTelegramViewAttributes() {
        telegramView.setCornerRadius(radius: 20)
        telegramView.setShadowColor(color: Colors.green)
        telegramView.setBackgroundColor(color: Colors.green)
    }
    
    func setRoundsNumberLabelAttributes() {
        roundsNumberLabel.setCornerRadius(radius: 22.5)
        roundsNumberLabel.setBackgroundColor(color: Colors.gray)
    }
    
    func setLobbyTypeLabelAttributes() {
        lobbyTypeLabel.setCornerRadius(radius: 22.5)
        lobbyTypeLabel.setBackgroundColor(color: Colors.gray)
    }
    
    func setRoundsNumberButtonAttributes() {
        roundsNumberButton.setCornerRadius(radius: 22.5)
        roundsNumberButton.setBackgroundColor(color: Colors.yellow)
    }
    
    func setLobbyTypeButtonAttributes() {
        lobbyTypeButton.setCornerRadius(radius: 22.5)
        lobbyTypeButton.setBackgroundColor(color: Colors.blue)
    }
    
    func setStartGameButtonAttributes() {
        startGameButton.setCornerRadius(radius: 30.5)
        startGameButton.setShadowColor(color: Colors.blue)
        startGameButton.setBackgroundColor(color: Colors.blue)
    }
    
    func configure() {
        setCopyButtonAttributes()
        setNameLabelAttributes()
        setTelegramViewAttributes()
        
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
}
