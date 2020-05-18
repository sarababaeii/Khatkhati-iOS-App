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
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
}

//TODO: show crown for lobbyLeader, coloring my name
//        colorView.layer.shadowRadius = 2.0
