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
        messageLabel.text = "\(message.username): \(message.content)"
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
}
