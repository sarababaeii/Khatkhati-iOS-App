//
//  PlayersCollectionViewCell.swift
//  Boomche
//
//  Created by Sara Babaei on 4/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var alphabetLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setAttributes(player: Player) {
        colorView.backgroundColor = player.color.topBackground
        alphabetLabel.text = player.username[0]
        nameLabel.text = player.username
    }
    
    func setColorViewAttributes() {
        colorView.layer.cornerRadius = 33
        
        colorView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        colorView.layer.shadowOpacity = 1.0
        colorView.layer.shadowRadius = 2.0
        colorView.layer.masksToBounds = false
        colorView.layer.shadowColor = Colors.gray.componentColor!.shadow?.cgColor
        
        colorView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
        colorView.layer.borderWidth = 3
    }
    func configure() {
        setColorViewAttributes()
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        configure()
    }
    
}
