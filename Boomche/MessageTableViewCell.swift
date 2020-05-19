//
//  MessageTableViewCell.swift
//  KhatKhati
//
//  Created by Sara Babaei on 4/8/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    
    func setCaption(_ message: Message) {
        if message.sender.hasGuessed == true {
            messageLabel.textColor = Colors.lightBlue.playerColor?.lightBackground
        }
        messageLabel.text = "\(message.sender.username): \(message.content)"
        messageLabel.textColor = message.sender.color.lightBackground
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
}
