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
    @IBOutlet weak var colorView: UIView!
    
    var color: Color?
    
    func setAttributes(color: Color) {
        self.color = color
//        colorButton
    }
    
    
    override func awakeFromNib(){
        super.awakeFromNib()
//        configure()
    }
}
