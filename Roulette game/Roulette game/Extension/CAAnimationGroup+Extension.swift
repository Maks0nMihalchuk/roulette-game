//
//  CAAnimationGroup+Extension.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import Foundation
import QuartzCore

extension CAAnimationGroup {
    
    func setupAnimation() {
        self.repeatCount = .zero
        self.isRemovedOnCompletion = false
        self.fillMode = CAMediaTimingFillMode.forwards
    }
}
