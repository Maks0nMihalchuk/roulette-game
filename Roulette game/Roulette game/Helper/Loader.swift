//
//  Loader.swift
//  Roulette game
//
//  Created by Максим Михальчук on 01.12.2022.
//

import NVActivityIndicatorView
import UIKit

class Loader {
    
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
    }
    lazy var activityIndicator: NVActivityIndicatorView =  {
        let frame = CGRect(origin: UIScreen.main.bounds.center, size: CGSize(width: 30, height: 30))
        let type = NVActivityIndicatorType.ballTrianglePath
        let actINd = NVActivityIndicatorView(frame: frame, type: type, color: self.color, padding: nil)
        actINd.isHidden = false
        actINd.center = UIScreen.main.bounds.center
        return actINd
    }()
    
    func show(for view: UIView) {
        guard !view.subviews.contains(activityIndicator) else { return }
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
    
    func show() {
        guard let view = UIWindow.key?.rootViewController?.view else { return }
        guard !view.subviews.contains(activityIndicator) else { return }
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func display() {
        // can fix show on tabBar or navigation
        guard let view = UIWindow.topViewController()?.view else { return }
        guard !view.subviews.contains(activityIndicator) else { return }
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hide() {
        activityIndicator.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
    
    static func remove() {
        guard let view = UIWindow.key?.rootViewController?.view else { return }
        guard let loader = view.subviews.filter({$0 is NVActivityIndicatorView}).first else { return }
        loader.removeFromSuperview()
    }
}

extension CGRect {
    var center: CGPoint { return CGPoint(x: midX, y: midY) }
}

