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
    
    //MARK: UI Handling
    func setWinnerAttributes() {
        winnerView.layer.cornerRadius = 29
        winnerScoreView.layer.cornerRadius = 22.5
        
        winnerNameLabel.textColor = EndGameViewController.winnerPlayer?.color.topBackground
        winnerScoreView.backgroundColor = EndGameViewController.winnerPlayer?.color.topBackground
        
        winnerScoreLabel.text = StringExtension.convertEnglishNumToPersianNum(num: String(EndGameViewController.winnerPlayer!.totalScore))
    }
    
    func setSecondPlaceAttributes() {
        secondPlaceView.layer.cornerRadius = 5
        secondPlaceScoreView.layer.cornerRadius = 5
        
        secondPlaceNameLabel.textColor = EndGameViewController.secondPlacePlayer?.color.topBackground
        secondPlaceScoreView.backgroundColor = EndGameViewController.secondPlacePlayer?.color.topBackground
        
        secondPlaceScoreLabel.text = StringExtension.convertEnglishNumToPersianNum(num: String(EndGameViewController.secondPlacePlayer!.totalScore))
    }
    
    func setThirdPlaceAttributes() {
        thirdPlaceView.layer.cornerRadius = 5
        thirdPlaceScoreView.layer.cornerRadius = 5
        
        thirdPlaceNameLabel.textColor = EndGameViewController.thirdPlacePlayer?.color.topBackground
        thirdPlaceScoreView.backgroundColor = EndGameViewController.thirdPlacePlayer?.color.topBackground
        
        thirdPlaceScoreLabel.text = StringExtension.convertEnglishNumToPersianNum(num: String(EndGameViewController.thirdPlacePlayer!.totalScore))
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
