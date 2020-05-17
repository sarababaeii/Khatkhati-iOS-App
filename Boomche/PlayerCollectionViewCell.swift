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
    @IBOutlet weak var lobbyLeaderImageView: UIImageView!
    @IBOutlet weak var alphabetLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setAttributes(player: Player) {
        colorView.backgroundColor = player.color.lightBackground
        alphabetLabel.text = player.username[0]
        nameLabel.text = player.username
    }
    
    func setColorViewAttributes() {
        colorView.layer.cornerRadius = 33
        
        colorView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        colorView.layer.shadowOpacity = 0.35 //alpha
        colorView.layer.shadowRadius = 2.0
        colorView.layer.masksToBounds = false
        colorView.layer.shadowColor = Colors.gray.componentColor!.shadow?.cgColor
        
        colorView.layer.borderColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1).cgColor
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

//TODO: show crown for lobbyLeader, coloring my name
