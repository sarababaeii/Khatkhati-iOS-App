//
//  EndViewController.swift
//  Boomche
//
//  Created by Sara Babaei on 4/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class EndGameViewController: UIViewController {
 
    @IBOutlet weak var winnerView: UIView!
    @IBOutlet weak var winnerNameLabel: UILabel!
    @IBOutlet weak var winnerScoreView: UIView!
    @IBOutlet weak var winnerScoreLabel: UILabel!
    
    @IBOutlet weak var secondPlaceView: UIView!
    @IBOutlet weak var secondPlaceNameLabel: UILabel!
    @IBOutlet weak var secondPlaceScoreView: UIView!
    @IBOutlet weak var secondPlaceScoreLabel: UILabel!
    
    @IBOutlet weak var thirdPlaceView: UIView!
    @IBOutlet weak var thirdPlaceNameLabel: UILabel!
    @IBOutlet weak var thirdPlaceScoreView: UIView!
    @IBOutlet weak var thirdPlaceScoreLabel: UILabel!
    
    @IBOutlet weak var homeButton: CustomButton!
    @IBOutlet weak var againButton: CustomButton!
    
    static var winnerPlayer: Player?
    static var secondPlacePlayer: Player?
    static var thirdPlacePlayer: Player?
    
    //MARK: Button Actions
    @IBAction func playAgainAction(_ sender: Any) {
        SocketIOManager.sharedInstance.playAgain()
    }
    
    @IBAction func homeAction(_ sender: Any) {
        Game.sharedInstance.resetRoom()
        self.showNextPage(identifier: "HomeViewController")
    }
    
    //MARK: UI Handling
    func setRankingAttributes(player: Player, nameLabel: UILabel, scoreLabel: UILabel, scoreView: UIView) {
        nameLabel.text = player.username
        scoreLabel.text = String(player.totalScore).convertEnglishNumToPersianNum()
        
        nameLabel.textColor = player.color.lightBackground
        scoreView.backgroundColor = player.color.lightBackground
    }
    
    func setWinnerAttributes() {
        winnerView.layer.cornerRadius = 29
        winnerScoreView.layer.cornerRadius = 22.5
        
        if let winner = EndGameViewController.winnerPlayer {
            setRankingAttributes(player: winner, nameLabel: winnerNameLabel, scoreLabel: winnerScoreLabel, scoreView: winnerScoreView)
        }
    }
    
    func setSecondPlaceAttributes() {
        secondPlaceView.layer.cornerRadius = 5
        secondPlaceScoreView.layer.cornerRadius = 5
        
        if let second = EndGameViewController.secondPlacePlayer {
            setRankingAttributes(player: second, nameLabel: secondPlaceNameLabel, scoreLabel: secondPlaceScoreLabel, scoreView: secondPlaceScoreView)
        }
    }
    
    func setThirdPlaceAttributes() {
        thirdPlaceView.layer.cornerRadius = 5
        thirdPlaceScoreView.layer.cornerRadius = 5
        
        if let third = EndGameViewController.thirdPlacePlayer {
            setRankingAttributes(player: third, nameLabel: thirdPlaceNameLabel, scoreLabel: thirdPlaceScoreLabel, scoreView: thirdPlaceScoreView)
        }
    }
    
    func setAgianButtonAttributes() {
        againButton.setCornerRadius(radius: 15)
        againButton.setBackgroundColor(color: Colors.blue.componentColor!)
    }
    
    func setHomeButtonAttributes() {
        homeButton.setCornerRadius(radius: 15)
        homeButton.setBackgroundColor(color: Colors.yellow.componentColor!)
        homeButton.setImage(image: UIImage(named: "Home")!)
    }
    
    func configure() {
        setWinnerAttributes()
        setSecondPlaceAttributes()
        setThirdPlaceAttributes()
        
        setAgianButtonAttributes()
        setHomeButtonAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}
