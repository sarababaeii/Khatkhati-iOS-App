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
        copyButton.setCornerRadius(radius: 21)
        copyButton.setShadowColor(red: 240/255, green: 6/255, blue: 197/255, alpha: 0.37)
        copyButton.setBackgroundColor(topRed: 255/255, topGreen: 0/255, topBlue: 244/255, topAlpha: 1,
                                          bottomRed: 255/255, bottomGreen: 11/255, bottomBlue: 150/255, bottomAlpha: 1)
    }
    
    func setNameLabelAttributes() {
        nameLabel.setCornerRadius(radius: 43)
        nameLabel.setBackgroundColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    }
    
    func setTelegramViewAttributes() {
        telegramView.setCornerRadius(radius: 20)
        telegramView.setBackgroundColor(topRed: 29/255, topGreen: 210/255, topBlue: 0/255, topAlpha: 1, bottomRed: 28/255, bottomGreen: 186/255, bottomBlue: 12/255, bottomAlpha: 1)
        telegramView.setShadowColor(red: 29/255, green: 198/255, blue: 6/266, alpha: 0.5)
    }
    
    func setRoundsNumberLabelAttributes() {
        roundsNumberLabel.setCornerRadius(radius: 22.5)
        roundsNumberLabel.setBackgroundColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    }
    
    func setLobbyTypeLabelAttributes() {
        lobbyTypeLabel.setCornerRadius(radius: 22.5)
        lobbyTypeLabel.setBackgroundColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    }
    
    func setRoundsNumberButtonAttributes() {
        roundsNumberButton.setCornerRadius(radius: 22.5)
        roundsNumberButton.setBackgroundColor(topRed: 255/255, topGreen: 215/255, topBlue: 0/255, topAlpha: 1,
                                              bottomRed: 254/255, bottomGreen: 189/255, bottomBlue: 0/255, bottomAlpha: 1)
    }
    
    func setLobbyTypeButtonAttributes() {
        lobbyTypeButton.setCornerRadius(radius: 22.5)
        lobbyTypeButton.setBackgroundColor(topRed: 0/255, topGreen: 177/255, topBlue: 255/255, topAlpha: 1,
                                           bottomRed: 3/255, bottomGreen: 138/255, bottomBlue: 255/255, bottomAlpha: 1)
    }
    
    func setStartGameButtonAttributes() {
        startGameButton.setCornerRadius(radius: 30.5)
        startGameButton.setShadowColor(red: 2/255, green: 156/255, blue: 255/255, alpha: 0.4)
        startGameButton.setBackgroundColor(topRed: 0/255, topGreen: 177/255, topBlue: 255/255, topAlpha: 1,
                                           bottomRed: 3/255, bottomGreen: 138/255, bottomBlue: 255/255, bottomAlpha: 1)
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
