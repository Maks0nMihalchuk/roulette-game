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
    
    static func nibInit() -> Self {
        let className = String(describing: self)
        return UINib(nibName: className, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Self
    }
    
    func loadViewFromNib() {
      let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
      let view = Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as! UIView
      view.translatesAutoresizingMaskIntoConstraints = false
      addSubview(view)

      let views = ["view": view]
      addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
      addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
      setNeedsUpdateConstraints()
    }
}

// MARK: - extension for add animation
extension UIView {
    
    func addAnimation(_ animation: CAAnimation, forKey: AnimationTypes) {
        self.layer.add(animation, forKey: forKey.rawValue)
    }
}
