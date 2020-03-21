//
//  GradientView.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/21/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {

    private let gradient : CAGradientLayer = CAGradientLayer()
    private let gradientStartColor: UIColor
    private let gradientEndColor: UIColor

    init(gradientStartColor: UIColor, gradientEndColor: UIColor) {
        self.gradientStartColor = gradientStartColor
        self.gradientEndColor = gradientEndColor
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }

    override public func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        gradient.type = .radial
        gradient.cornerRadius = self.layer.cornerRadius //must be called after setCornerRadius
        gradient.colors = [gradientEndColor.cgColor, gradientStartColor.cgColor]
//        gradient.startPoint = CGPoint(x: 1, y: 0)
//        gradient.endPoint = CGPoint(x: 0.2, y: 1)
//        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
//        }
    }
}

//class GradientView: UIView {
//
//    let gradient : CAGradientLayer
//
//    init(gradient: CAGradientLayer) {
//        self.gradient = gradient
//        super.init(frame: .zero)
//        self.gradient.frame = self.bounds
//        self.layer.insertSublayer(self.gradient, at: 0)
//    }
//
//    convenience init(colors: [UIColor], locations:[Float] = [0.0, 1.0]) {
//        let gradient = CAGradientLayer()
//        gradient.colors = colors.map { $0.cgColor }
//        gradient.locations = locations.map { NSNumber(value: $0) }
//        self.init(gradient: gradient)
//    }
//
//    override func layoutSublayers(of layer: CALayer) {
//        super.layoutSublayers(of: layer)
//        self.gradient.frame = self.bounds
//    }
//
//    required init?(coder: NSCoder) { fatalError("no init(coder:)") }
//}
