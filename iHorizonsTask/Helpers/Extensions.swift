//
//  Extensions.swift
//  iHorizonsTask
//
//  Created by Ahmed Madeh on 16/12/2021.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable var borderColor: UIColor {
        set {
            layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable public var circleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
        }
        set {
            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }
    
    @IBInspectable var shadow: UIColor {
        set {
            let shadowLayer = ShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.frame, cornerRadius: layer.cornerRadius).cgPath
            shadowLayer.fillColor = UIColor.clear.cgColor
            shadowLayer.shadowColor = newValue.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
            shadowLayer.shadowOpacity = 0.6
            shadowLayer.shadowRadius = 4
            shadowLayer.view = self
            shadowLayer.cornerRadius = layer.cornerRadius
            clipsToBounds = true

            if let view = superview{
                view.layer.insertSublayer(shadowLayer, at: 0)
            }
        } get {
            return UIColor.clear
        }
    }
}

extension UITableView {
    func registerCell<T: UITableViewCell>(ofType type: T.Type){
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }
    func dequeueReusableCell<T: UITableViewCell>() -> T? {
        return dequeueReusableCell(withIdentifier: T.identifier) as? T
    }
}

extension UITableViewCell {
    static var identifier: String {
         return String(describing: self)
     }
    static var nib: UINib {
        return UINib.init(nibName: identifier, bundle: .main)
    }
}

extension Date {
    func string(format: String, identifier: Calendar.Identifier = .gregorian) -> String {
        let formatter = DateFormatter.init(withFormat: format, locale: "en")
        formatter.calendar = Calendar(identifier: identifier)
        return formatter.string(from: self)
    }
}
