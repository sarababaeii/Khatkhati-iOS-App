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
        if message.sender.hasGuessed && !message.isAnswer{
            messageLabel.font = UIFont(name: "Vazir-Thin", size: 19)
        }
        messageLabel.text = "\(message.sender.username): \(message.content)"
        messageLabel.textColor = message.sender.color.lightBackground
    }
    
    func createAttributesForFontStyle( _ style: UIFont.TextStyle, withTrait trait: UIFontDescriptor.SymbolicTraits
    ) -> [NSAttributedString.Key: Any] {
      let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
      let descriptorWithTrait = fontDescriptor.withSymbolicTraits(trait)
      let font = UIFont(descriptor: descriptorWithTrait!, size: 0)
      return [.font: font]
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
}
