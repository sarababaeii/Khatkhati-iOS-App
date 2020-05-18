//
//  ColorCollectionViewCell.swift
//  Boomche
//
//  Created by Sara Babaei on 5/17/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorButton: UIButton!
    
    var color: Color = Colors.black.drawingColor!
    
    func setAttributes(color: Color) {
        self.color = color
        colorButton.layer.backgroundColor = color.lightBackground.cgColor
        colorButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func colorPicked(_ sender: Any) {
        Game.sharedInstance.drawing?.currentColorCell?.unSelectColor()
        self.selectColor()
    }
    
    func selectColor() {
        Game.sharedInstance.drawing?.currentColorCell = self
        colorButton.layer.borderWidth = 5
    }
    
    func unSelectColor() {
        colorButton.layer.borderWidth = 0
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
}
