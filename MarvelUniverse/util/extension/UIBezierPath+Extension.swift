//
//  UIBezierPath+Extension.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 21/10/21.
//

import UIKit

extension UIBezierPath {
    /// Creates and returns a new UIBezierPath object initialized with a circular path
    convenience init(center: CGPoint, radius: CGFloat) {
        self.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
    }
}
