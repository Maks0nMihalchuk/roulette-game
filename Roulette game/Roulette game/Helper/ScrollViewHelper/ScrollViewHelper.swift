//
//  ScrollViewHelper.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import UIKit

struct AnimationParameters {
    let keyboardFrameHeight: CGFloat
    var duration: Double = 0.3
    var animationCurve: UIView.AnimationOptions = UIView.AnimationOptions.curveEaseInOut
    
    init(keyboardFrameHeight: CGFloat) {
        self.keyboardFrameHeight = keyboardFrameHeight
    }
    
    init(keyboardFrameHeight: CGFloat, duration: Double, animationCurve: UIView.AnimationOptions) {
        self.keyboardFrameHeight = keyboardFrameHeight
        self.duration = duration
        self.animationCurve = animationCurve
    }
}

protocol ScrollViewHelperDelegate: AnyObject {
    func keyboardAnimation(with animationParameters: AnimationParameters)
}

class ScrollViewHelper: ScrollViewHelperProtocol {
    
    weak var delegate: ScrollViewHelperDelegate?
    
    func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }

        let keyboardFrameHeight = getKeyboardHeight(userInfo: userInfo)
        let duration = getAnimationDuration(userInfo: userInfo)
        let animationCurveRaw = getAnimationCurveRaw(userInfo: userInfo)
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        delegate?.keyboardAnimation(with: AnimationParameters(keyboardFrameHeight: keyboardFrameHeight, duration: duration, animationCurve: animationCurve))
    }

    func keyboardWillHide(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }

        let duration = getAnimationDuration(userInfo: userInfo)
        let animationCurveRaw = getAnimationCurveRaw(userInfo: userInfo)
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        delegate?.keyboardAnimation(with: AnimationParameters(keyboardFrameHeight: .zero,duration: duration, animationCurve: animationCurve))
    }
    
    func keyboardWillChangeFrame(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }

        let keyboardFrameHeight = getKeyboardHeight(userInfo: userInfo)
        let duration = getAnimationDuration(userInfo: userInfo)
        let animationCurveRaw = getAnimationCurveRaw(userInfo: userInfo)
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        delegate?.keyboardAnimation(with: AnimationParameters(keyboardFrameHeight: keyboardFrameHeight, duration: duration, animationCurve: animationCurve))
    }
    
    private func getKeyboardHeight(userInfo: [AnyHashable: Any]) -> CGFloat {
        let key = UIResponder.keyboardFrameEndUserInfoKey

        guard let keyboardFrame = userInfo[key] as? NSValue else { return .zero }

        return keyboardFrame.cgRectValue.height
    }

    private func getAnimationDuration(userInfo: [AnyHashable: Any]) -> Double {
        let key = UIResponder.keyboardAnimationDurationUserInfoKey

        guard let duration = userInfo[key] as? NSNumber else { return .zero }

        return duration.doubleValue
    }

    private func getAnimationCurveRaw(userInfo: [AnyHashable: Any]) -> UInt {
        let key = UIResponder.keyboardAnimationCurveUserInfoKey
        let defaultAnimationRaw = UIView.AnimationOptions.curveEaseInOut.rawValue

        guard let animationCurveRaw = (userInfo[key] as? NSNumber)?.uintValue else { return defaultAnimationRaw }

        return animationCurveRaw
    }
}
