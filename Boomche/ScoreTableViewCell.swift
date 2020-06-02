//
//  ScoreTableViewCell.swift
//  Boomche
//
//  Created by Sara Babaei on 4/16/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    @IBOutlet weak var bonusImage: UIImageView!
    @IBOutlet weak var playAgainCheckMark: UIImageView!
    @IBOutlet weak var colorView: UIView!
    
    func setAttributes(player: Player){
        nameLabel.text = player.username
        totalScoreLabel.text = String(player.totalScore).convertEnglishNumToPersianNum()
        nameLabel.textColor = player.color.lightBackground
        colorView.backgroundColor = player.color.lightBackground
    }
    
    func setBonus(player: Player) {
        if Game.sharedInstance.joinedState == 2 {
            return
        }
        currentScoreLabel.text = "+\(String(player.currentScore).convertEnglishNumToPersianNum()) امتیاز"
        if player.isPainter {
           bonusImage.image = UIImage(named: "Brush")
        }
        if player.isFirstGuesser {
           bonusImage.image = UIImage(named: "Medal")
        }
    }
    
    func setCupImage(row: Int) {
        switch row {
        case 0:
            bonusImage.image = UIImage(named: "GoldCup")
        case 1:
            bonusImage.image = UIImage(named: "SilverCup")
        case 2:
            bonusImage.image = UIImage(named: "BronzeCup")
        default:
            return
        }
    }
    
    func setPlayAgain() {
        if playAgainCheckMark.isHidden {
            playAgainCheckMark.isHidden = false
        }
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
}
