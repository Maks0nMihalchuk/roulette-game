//
//  UiView+Extension.swift
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
}
