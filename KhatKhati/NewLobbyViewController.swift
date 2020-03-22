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
        copyButton.setCornerRadius(radius: 20.5)
        copyButton.setShadowColor(color: ComponentColors.pink)
        copyButton.setBackgroundColor(color: ComponentColors.pink)
    }
    
    func setNameLabelAttributes() {
        nameLabel.setCornerRadius(radius: 43)
        nameLabel.setBackgroundColor(color: ComponentColors.gray)
    }
    
    func setTelegramViewAttributes() {
        telegramView.setCornerRadius(radius: 20)
        telegramView.setShadowColor(color: ComponentColors.green)
        telegramView.setBackgroundColor(color: ComponentColors.green)
    }
    
    func setRoundsNumberLabelAttributes() {
        roundsNumberLabel.setCornerRadius(radius: 22.5)
        roundsNumberLabel.setBackgroundColor(color: ComponentColors.gray)
    }
    
    func setLobbyTypeLabelAttributes() {
        lobbyTypeLabel.setCornerRadius(radius: 22.5)
        lobbyTypeLabel.setBackgroundColor(color: ComponentColors.gray)
    }
    
    func setRoundsNumberButtonAttributes() {
        roundsNumberButton.setCornerRadius(radius: 22.5)
        roundsNumberButton.setBackgroundColor(color: ComponentColors.yellow)

        
//        let gradientView1 = GradientView(gradientStartColor: Colors.yellow.topBackground, gradientEndColor: Colors.yellow.bottomBackground)
//        
//                
//        gradientView1.translatesAutoresizingMaskIntoConstraints = false
//        let horizontalConstraint = gradientView1.centerXAnchor.constraint(equalTo: roundsNumberButton.centerXAnchor)
//        let verticalConstraint = gradientView1.centerYAnchor.constraint(equalTo: roundsNumberButton.centerYAnchor)
//        let widthConstraint = gradientView1.widthAnchor.constraint(equalToConstant: 100)
//        let heightConstraint = gradientView1.heightAnchor.constraint(equalToConstant: 100)
//        
//        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func setLobbyTypeButtonAttributes() {
        lobbyTypeButton.setCornerRadius(radius: 22.5)
        lobbyTypeButton.setBackgroundColor(color: ComponentColors.blue)
    }
    
    func setStartGameButtonAttributes() {
        startGameButton.setCornerRadius(radius: 30)
        startGameButton.setShadowColor(color: ComponentColors.blue)
        startGameButton.setBackgroundColor(color: ComponentColors.blue)
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
