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
    
    init(playersCollectionView: UICollectionView) {
        self.playersCollectionView = playersCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Game.sharedInstance.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCellID", for: indexPath) as! PlayerCollectionViewCell
        let player = playerDataSource(indexPath: indexPath)
        cell.setAttributes(player: player!)
        return cell
    }
    
    func playerDataSource(indexPath: IndexPath) -> Player? {
        return Game.sharedInstance.players[indexPath.row]
    }
    
    func insertPlayer(_ player: Player?, at indexPath: IndexPath?){
        if let player = player, let indexPath = indexPath {
            playersCollectionView.performBatchUpdates( {
                
                Game.sharedInstance.players.insert(player, at: indexPath.item)
                playersCollectionView.insertItems(at: [indexPath])
                
            }, completion: nil)
        }
    }

    func deletePlayer(at indexPath: IndexPath?){
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
            let username = user["name"] as! String //socketID
            let colorCode = user["color"] as! Int

            let indexPath = IndexPath(item: Game.sharedInstance.players.count, section: 0)
            if Game.sharedInstance.me.username == username { //socketID
                Game.sharedInstance.me.colorCode = colorCode
                insertPlayer(Game.sharedInstance.me, at: indexPath)
            } else {
                insertPlayer(Player(username: username, colorCode: colorCode), at: indexPath)
            }
        }
    }
}
