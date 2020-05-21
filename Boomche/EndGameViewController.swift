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
    @IBOutlet weak var againButton: UIButton!
    
    //MARK: Button Actions
    @IBAction func playAgainAction(_ sender: Any) {
        Game.sharedInstance.playAgain()
        SocketIOManager.sharedInstance.playAgain()
    }
    
    @IBAction func homeAction(_ sender: Any) {
        Game.sharedInstance.gameFinished()
        self.showNextPage(identifier: "HomeViewController")
    }
    
    //MARK: UI Handling
    func setAttributes(player: Player, nameLabel: UILabel, scoreLabel: UILabel, scoreView: UIView) {
        nameLabel.text = player.username
        scoreLabel.text = String(player.totalScore).convertEnglishNumToPersianNum()
        
        nameLabel.textColor = player.color.lightBackground
        scoreView.backgroundColor = player.color.lightBackground
    }
    
    func setRankingAttributes() {
        if Game.sharedInstance.players.count > 0 {
            let winner = Game.sharedInstance.players[0]
            setAttributes(player: winner, nameLabel: winnerNameLabel, scoreLabel: winnerScoreLabel, scoreView: winnerScoreView)
        }
        if Game.sharedInstance.players.count > 1 {
            let second = Game.sharedInstance.players[1]
            setAttributes(player: second, nameLabel: secondPlaceNameLabel, scoreLabel: secondPlaceScoreLabel, scoreView: secondPlaceScoreView)
        }
        if Game.sharedInstance.players.count > 2 {
            let third = Game.sharedInstance.players[2]
            setAttributes(player: third, nameLabel: thirdPlaceNameLabel, scoreLabel: thirdPlaceScoreLabel, scoreView: thirdPlaceScoreView)
        }
    }
    
    func setHomeButtonAttributes() {
        homeButton.setImage(image: UIImage(named: "Home")!)
    }
    
    func configure() {
        setRankingAttributes()

        setHomeButtonAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
}
