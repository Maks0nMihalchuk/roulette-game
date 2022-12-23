//
//  UIAlertController+Extension.swift
//  Roulette game
//
//  Created by Максим Михальчук on 19.12.2022.
//

import UIKit

extension UIAlertController {
    
    func addActions(_ actions: [UIAlertAction]) {
        actions.forEach {
            self.addAction($0)
        }
    }
}
