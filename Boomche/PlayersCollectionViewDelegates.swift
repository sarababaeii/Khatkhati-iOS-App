//
//  PlayersCollectionViewDelegates.swift
//  Boomche
//
//  Created by Sara Babaei on 5/3/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class PlayersCollectionViewDelegates: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var playersCollectionView: UICollectionView
    
    //MARK: Initializer
    init(playersCollectionView: UICollectionView) {
        self.playersCollectionView = playersCollectionView
    }
    
    //MARK: Protocol Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Game.sharedInstance.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCellID", for: indexPath) as! PlayerCollectionViewCell
        
        if let player = playerDataSource(indexPath: indexPath) {
            cell.setAttributes(player: player)
            if player.isMe() {
                cell.setTextColor(color: player.color)
            }
        }
        return cell
    }
    
    func playerDataSource(indexPath: IndexPath) -> Player? {
        if indexPath.row < Game.sharedInstance.players.count {
            return Game.sharedInstance.players[indexPath.row]
        }
        return nil
    }
    
    //MARK: Functions
    func insertPlayer(_ player: Player?, at indexPath: IndexPath?) {
        if let player = player, let indexPath = indexPath {
            playersCollectionView.performBatchUpdates({
                Game.sharedInstance.players.insert(player, at: indexPath.item)
                playersCollectionView.insertItems(at: [indexPath])
            }, completion: nil)
        }
    }

    func deletePlayer(at indexPath: IndexPath?) {
        if let indexPath = indexPath {
            playersCollectionView.performBatchUpdates({
                Game.sharedInstance.players.remove(at: indexPath.item)
                playersCollectionView.deleteItems(at: [indexPath])
            }, completion: nil)
        }
    }
    
    func updatePlayers(users: [[String : Any]]) {
        while Game.sharedInstance.players.count > 0 {
            deletePlayer(at: IndexPath(item: Game.sharedInstance.players.count - 1, section: 0))
        }
        
        for user in users {
            let player = Player(socketID: user["socket_id"] as! String, username: user["name"] as! String, colorCode: user["color"] as! Int)
            let indexPath = IndexPath(item: Game.sharedInstance.players.count, section: 0)
            
            if player.isMe() {
                Game.sharedInstance.me.colorCode = player.colorCode
                insertPlayer(Game.sharedInstance.me, at: indexPath)
            } else {
                insertPlayer(player, at: indexPath)
            }
        }
    }
}
