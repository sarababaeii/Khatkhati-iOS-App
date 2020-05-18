//
//  ColorsCollectionViewDelegates.swift
//  Boomche
//
//  Created by Sara Babaei on 5/18/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class ColorsCollectionViewDelegates: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var colorsCollectionView: UICollectionView
    var colors: [Color]
    
    var blackCell: ColorCollectionViewCell?
    
    init(colorsCollectionView: UICollectionView, colors: [Color]) {
        self.colorsCollectionView = colorsCollectionView
        self.colors = colors
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCellID", for: indexPath) as! ColorCollectionViewCell
        cell.setAttributes(color: colorDataSource(indexPath: indexPath)!)
        
        if let black = Colors.black.drawingColor,
            cell.color.lightBackground == black.lightBackground {
            blackCell = cell
            cell.selectColor()
        }
        return cell
    }
    
    func colorDataSource(indexPath: IndexPath) -> Color? {
        return colors[indexPath.row]
    }
    
    func insertColor(_ color: Color?, at indexPath: IndexPath?){
        if let color = color, let indexPath = indexPath {
            colorsCollectionView.performBatchUpdates( {
                
                colors.insert(color, at: indexPath.item)
                colorsCollectionView.insertItems(at: [indexPath])
                
            }, completion: nil)
        }
    }
}
