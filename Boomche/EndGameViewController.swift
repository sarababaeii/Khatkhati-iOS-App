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
    
    
    @IBAction func playAgainAction(_ sender: Any) {
        SocketIOManager.sharedInstance.playAgain()
    }
    
    @IBAction func homeAction(_ sender: Any) {
        self.showNextPage(identifier: "HomeViewController")
    }
    
    //MARK: Socket Management
    func addSocketHandler() {
        SocketIOManager.sharedInstance.socket?.on("start_game") { data, ack in
            print("^^^^^RECEIVING WORDS^^^^^^")
            
            SocketIOManager.sharedInstance.receiveWords(from: self, data: data[0] as! [String : Any])
        }
    }
    
    //MARK: UI Handling
    func setWinnerAttributes() {
        winnerView.layer.cornerRadius = 29
        winnerScoreView.layer.cornerRadius = 22.5
        
        winnerNameLabel.textColor = EndGameViewController.winnerPlayer?.color.topBackground
        winnerScoreView.backgroundColor = EndGameViewController.winnerPlayer?.color.topBackground
        
        if let winner = EndGameViewController.winnerPlayer {
            winnerScoreLabel.text = String(winner.totalScore).convertEnglishNumToPersianNum()
        }
    }
    
    func setSecondPlaceAttributes() {
        secondPlaceView.layer.cornerRadius = 5
        secondPlaceScoreView.layer.cornerRadius = 5
        
        secondPlaceNameLabel.textColor = EndGameViewController.secondPlacePlayer?.color.topBackground
        secondPlaceScoreView.backgroundColor = EndGameViewController.secondPlacePlayer?.color.topBackground
        
        if let second = EndGameViewController.secondPlacePlayer {
            secondPlaceScoreLabel.text = String(second.totalScore).convertEnglishNumToPersianNum()
        }
    }
    
    func setThirdPlaceAttributes() {
        thirdPlaceView.layer.cornerRadius = 5
        thirdPlaceScoreView.layer.cornerRadius = 5
        
        thirdPlaceNameLabel.textColor = EndGameViewController.thirdPlacePlayer?.color.topBackground
        thirdPlaceScoreView.backgroundColor = EndGameViewController.thirdPlacePlayer?.color.topBackground
        
        if let third = EndGameViewController.thirdPlacePlayer {
            thirdPlaceScoreLabel.text = String(third.totalScore).convertEnglishNumToPersianNum()
        }
    }
    
    func setAgianButtonAttributes() {
        againButton.setCornerRadius(radius: 15)
        againButton.setBackgroundColor(color: Colors.blue.componentColor!)
    }
    
    func setHomeButtonAttributes() {
        homeButton.setCornerRadius(radius: 15)
        homeButton.setBackgroundColor(color: Colors.yellow.componentColor!)
        homeButton.setImage(UIImage(named: "Home"), for: .normal)
    }
    
    func configure() {
        addSocketHandler()
        
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

//TODO: button actions, homeButton image
