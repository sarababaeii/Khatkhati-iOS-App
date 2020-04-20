//
//  CustomTextField.swift
//  Boomche
//
//  Created by Sara Babaei on 4/21/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    func setLeftIcon(icon: UIImage, padding: CGFloat) {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: icon.size.width+padding, height: icon.size.height) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: icon.size.width, height: icon.size.height))
       
        iconView.image = icon
        outerView.addSubview(iconView)

        leftView = outerView
        leftViewMode = .always
  }
}
