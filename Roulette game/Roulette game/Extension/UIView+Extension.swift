//
//  UIView+Extension.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import UIKit

extension UIView {

    func rounded(_ radius: CGFloat? = nil) {
        if let radius = radius {
            layer.cornerRadius = radius
        } else {
            layer.cornerRadius = min(bounds.width, bounds.height) / 2
        }
    }
    
    func settingBorder(color: UIColor, width: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func settingShadow(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
    public func reloadLayout() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

// MARK: - extension for add animation
extension UIView {
    
    func addAnimation(_ animation: CAAnimation, forKey: AnimationTypes) {
        self.layer.add(animation, forKey: forKey.rawValue)
    }
}
