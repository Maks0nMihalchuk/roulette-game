//
//  CABasicAnimation+Extension.swift
//  Roulette game
//
//  Created by Максим Михальчук on 07.12.2022.
//

import Foundation
import QuartzCore

extension CABasicAnimation {
    
    func setupAnimation() {
        self.repeatCount = .zero
        self.isRemovedOnCompletion = false
        self.fillMode = CAMediaTimingFillMode.forwards
        self.timingFunction = CAMediaTimingFunction(name: .easeOut)
    }
}
