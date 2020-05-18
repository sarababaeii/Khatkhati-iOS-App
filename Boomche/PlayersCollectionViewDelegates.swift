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
    var players = [Player]()
    
    init(playersCollectionView: UICollectionView) {
        self.playersCollectionView = playersCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCellID", for: indexPath) as! PlayerCollectionViewCell
        let player = playerDataSource(indexPath: indexPath)
        cell.setAttributes(player: player!)
        return cell
    }
    
    func playerDataSource(indexPath: IndexPath) -> Player? {
        return players[indexPath.row]
    }
    
    func insertPlayer(_ player: Player?, at indexPath: IndexPath?){
        if let player = player, let indexPath = indexPath {
            playersCollectionView.performBatchUpdates( {
                
                players.insert(player, at: indexPath.item)
                playersCollectionView.insertItems(at: [indexPath])
                
            }, completion: nil)
        }
    }

    func deletePlayer(at indexPath: IndexPath?){
        if let indexPath = indexPath {
            playersCollectionView.performBatchUpdates({
                
                players.remove(at: indexPath.item)
                playersCollectionView.deleteItems(at: [indexPath])
                
            }, completion: nil)
        }
    }
    
    func updatePlayers(users: [[String : Any]]) {//should be more efficient with socket_id
        while players.count > 0 {
            deletePlayer(at: IndexPath(item: players.count - 1, section: 0))
        }
        
        for i in 0 ..< users.count {
            let colorCode = users[i]["color"] as! Int
            let username = users[i]["name"] as! String
           
            insertPlayer(Player(username: username, colorCode: colorCode), at: IndexPath(item: players.count, section: 0))
        }
    }
}
