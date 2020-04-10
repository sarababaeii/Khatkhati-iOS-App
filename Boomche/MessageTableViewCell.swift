//
//  MessageTableViewCell.swift
//  KhatKhati
//
//  Created by Sara Babaei on 4/8/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

protocol MessageCellDelegate {
    func messageCell(_ cell: MessageTableViewCell, message: Message)
}

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    
    
}
