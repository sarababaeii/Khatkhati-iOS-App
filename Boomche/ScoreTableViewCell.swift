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
        currentScoreLabel.text = "+\(StringExtension.convertEnglishNumToPersianNum(num: String(player.currentScore))) امتیاز"
        totalScoreLabel.text = StringExtension.convertEnglishNumToPersianNum(num: String(player.totalScore))
        nameLabel.textColor = player.color.topBackground
        colorView.backgroundColor = player.color.topBackground
        
        if player.isPainter {
            bonusImage.image = UIImage(named: "Brush")
        }
        if player.isFirstGuesser {
            bonusImage.image = UIImage(named: "Medal")
        }
    }
    
    func configure() {
        wholeView.layer.cornerRadius = 5
        colorView.layer.cornerRadius = 5
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        configure()
    }
}