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
    
    //MARK: Initializer
    init(chatTableView: UITableView) {
        self.chatTableView = chatTableView
    }
    
    //MARK: Protocol Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCellID", for: indexPath) as! MessageTableViewCell
        if let message = messageDataSource(indexPath: indexPath) {
            cell.setCaption(message)
        }
        return cell
    }
    
    func messageDataSource(indexPath: IndexPath) -> Message? {
        if indexPath.row < messages.count {
            return messages[indexPath.row]
        }
        return nil
    }
    
    //MARK: Functions
    func insertMessage(_ message: Message?){
        if let message = message {
            if Game.sharedInstance.me.hasGuessed == false && message.sender.hasGuessed == true && message.isAnswer == false {
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
