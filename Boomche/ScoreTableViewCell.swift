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
    @IBOutlet weak var colorView: UIView!
    
    
    func setAttributes(player: Player){
        nameLabel.text = player.username
        currentScoreLabel.text = "\(convertEnglishNumToPersianNum(num: String(player.currentScore))) امتیاز"
        totalScoreLabel.text = convertEnglishNumToPersianNum(num: String(player.totalScore))
        nameLabel.textColor = player.color.topBackground
        colorView.backgroundColor = player.color.topBackground
        
        if player.isPainter {
            bonusImage.image = UIImage(named: "Brush")
        }
        if player.isFirstGuesser {
            bonusImage.image = UIImage(named: "Medal")
        }
    }
    
    func convertEnglishNumToPersianNum(num: String) -> String {
        //let number = NSNumber(value: Int(num)!)
        let format = NumberFormatter()
        format.locale = Locale(identifier: "fa_IR")
        
        let number =   format.number(from: num)
        let faNumber = format.string(from: number!)
        
        return faNumber!
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
//        configure()
    }
    
}
