//
//  MessageTableViewDelegates.swift
//  Boomche
//
//  Created by Sara Babaei on 4/27/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class MessageTableViewDelegates: NSObject, UITableViewDelegate, UITableViewDataSource {
    var chatTableView: UITableView
    var messages = [Message]()
    
    init(chatTableView: UITableView) {
        self.chatTableView = chatTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCellID", for: indexPath) as! MessageTableViewCell
        let message = messageDataSource(indexPath: indexPath)
        cell.setCaption(message!)
        return cell
    }
    
    func messageDataSource(indexPath: IndexPath) -> Message? {
        return messages[indexPath.row]
    }
    
    func insertMessage(_ message: Message?){
        if let message = message {
            if Game.sharedInstance.me.hasGuessed == false && message.sender.hasGuessed == true {
                return
            }
            
            let indexPath = IndexPath(row: messages.count, section: 0)
            
            chatTableView.beginUpdates()
            
            messages.insert(message, at: indexPath.row)
            chatTableView.insertRows(at: [indexPath], with: .automatic)
        
            chatTableView.endUpdates()
        }
    }
}
