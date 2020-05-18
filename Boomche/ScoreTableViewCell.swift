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
    
    @IBOutlet weak var wholeView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    @IBOutlet weak var bonusImage: UIImageView!
    @IBOutlet weak var colorView: UIView!
    
    func setAttributes(player: Player){
        nameLabel.text = player.username
        currentScoreLabel.text = "+\(String(player.currentScore).convertEnglishNumToPersianNum()) امتیاز"
        totalScoreLabel.text = String(player.totalScore).convertEnglishNumToPersianNum()
        nameLabel.textColor = player.color.lightBackground
        colorView.backgroundColor = player.color.lightBackground
        
        if player.isPainter {
            bonusImage.image = UIImage(named: "Brush")
        }
        if player.isFirstGuesser {
            bonusImage.image = UIImage(named: "Medal")
        }
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
}
