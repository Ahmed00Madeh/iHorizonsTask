//
//  ShapeLayer.swift
//  iHorizonsTask
//
//  Created by Ahmed Madeh on 16/12/2021.
//

import UIKit

class ShapeLayer: CAShapeLayer {

    weak var view: UIView?
    var color: UIColor = .clear
    
    convenience init(color: UIColor, frame: CGRect, cornerRadius: CGFloat) {
        self.init()
        self.color = color
        path = UIBezierPath(roundedRect: self.frame, cornerRadius: cornerRadius).cgPath
        fillColor = UIColor.clear.cgColor
        shadowColor = color.cgColor
        shadowPath = path
        shadowOffset = CGSize(width: 0, height: 0)
        shadowOpacity = 0.8
        shadowRadius = 5
        self.cornerRadius = cornerRadius
    }
    
}
