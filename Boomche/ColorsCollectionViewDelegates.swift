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
    
    //MARK: Initializer
    init(colorsCollectionView: UICollectionView, colors: [Color]) {
        self.colorsCollectionView = colorsCollectionView
        self.colors = colors
    }
    
    //MARK: Protocol Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCellID", for: indexPath) as! ColorCollectionViewCell
        cell.setAttributes(color: colorDataSource(indexPath: indexPath)!)
        ifIsBlack(cell: cell)
        return cell
    }
    
    func colorDataSource(indexPath: IndexPath) -> Color? {
        return colors[indexPath.row]
    }
    
    //MARK: Functions
    func ifIsBlack(cell: ColorCollectionViewCell) {
        guard let black = Colors.black.drawingColor,
            cell.color.lightBackground == black.lightBackground else {
            return
        }
        blackCell = cell
        cell.selectColor()
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
