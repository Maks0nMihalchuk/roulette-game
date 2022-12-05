//
//  UITextField+Extension.swift
//  Roulette game
//
//  Created by Максим Михальчук on 03.12.2022.
//

import UIKit

extension UITextField {
    
    func setBorderColor(with color: UIColor, borderWidth: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = 8
    }
}
