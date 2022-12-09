//
//  AnimationManager.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import Foundation
import QuartzCore
import UIKit.UIView

enum AnimationTypes: String {
    case zRotation = "transform.rotation.z"
    case animation = "rotationAnimation"
}

protocol AnimationManagerProtocol {
    
    func ballIdentityTransform() -> CGAffineTransform
    func getFinishScaleOfBall() -> CGAffineTransform
    
    func getNumberOfBallBounces() -> Int
    func resetNumberOfBallBounces()
    func updateNumberOfBallBounces()
    func getRouletteAnimation() -> CABasicAnimation
    func getBallAnimations(with angle: Double) -> CAAnimationGroup
    func getStandardScaleOfBall() -> CGAffineTransform
    func getIntermediateScaleOfBall() -> CGAffineTransform
    func getDefaultBallTransformRotated() -> CGAffineTransform
    func ballTransform(animations: @escaping VoidCallBlock,
                       completion: @escaping BlockWith<Bool>)
    func springAnimate(preparation: @escaping VoidCallBlock,
                       animations: @escaping VoidCallBlock,
                       completion: @escaping BlockWith<Bool>)
}

class AnimationManager: AnimationManagerProtocol {
    
    private enum Constants {
        static let one: CGFloat = 1
        static let rouletteAnimationDuration: Double = 10
        static let ballGroupAnimationDuration: Double = 10
        static let rouletteAnimationToValue: Double = 6
        static let defaultBallRotation = 0.455
        static let fullTurnInRadians = Double.pi * 2
        static let numberOfTurnsOfBallCounterclockwise: Double = 5
        static let durationOfAnimationOfBallCounterclockwise = 7.9
        static let ballAnimationClockwiseDuration: Double = 2
        static let ballAnimationStartTimeClockwise: Double = 8
        static let ballTransformDuratoion: Double = 3
        static let ballTransformDelay: Double = 5 // 5.5
        static let ballSpringAnimateDuration: Double = 0.6 // 0.6
        static let usingSpringWithDamping: Double = 0.9
        static let initialSpringVelocity: Double = 0.6
        static let intermediateScaleOfBall: Double = 0.62
        static let finishScaleOfBall: Double = 0.58
    }
    
    private var numberOfBallBounces = 0
    
    // MARK: - roulette animation
    func getRouletteAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: AnimationTypes.zRotation.rawValue)
        animation.duration = Constants.rouletteAnimationDuration 
        animation.toValue = (Constants.fullTurnInRadians
                             * Constants.rouletteAnimationToValue)
        animation.setupAnimation()
        
        return animation
    }
    
    // MARK: - ball animations
    func springAnimate(preparation: @escaping VoidCallBlock, animations: @escaping VoidCallBlock, completion: @escaping BlockWith<Bool>) {
        preparation()
        UIView.animate(withDuration: Constants.ballSpringAnimateDuration,
                       delay: .zero,
                       usingSpringWithDamping: Constants.usingSpringWithDamping,
                       initialSpringVelocity: Constants.initialSpringVelocity,
                       options: [.curveEaseInOut]) {
            animations()
        } completion: { finished in
            completion(finished)
        }
    }
    
    func ballTransform(animations: @escaping VoidCallBlock, completion: @escaping BlockWith<Bool>) {
        UIView.animate(withDuration: Constants.ballTransformDuratoion,
                       delay: Constants.ballTransformDelay,
                       options: [.curveEaseIn , .curveEaseInOut]) {
            animations()
        } completion: { finished in
            completion(finished)
        }
    }
    
    func getBallAnimations(with angle: Double) -> CAAnimationGroup {
        let animationCounterclockwise = setupBallAnimationCounterclockwise()
        let ballAnimationClockwise = setupBallAnimationClockwise(with: angle)
        let groupBallAnimations = CAAnimationGroup()
        groupBallAnimations.duration = Constants.ballGroupAnimationDuration
        groupBallAnimations.setupAnimation()
        
        groupBallAnimations.animations = [animationCounterclockwise, ballAnimationClockwise]
        return groupBallAnimations
    }
    
    private func setupBallAnimationCounterclockwise() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: AnimationTypes.zRotation.rawValue)
        animation.fromValue = -Constants.defaultBallRotation
        animation.toValue = -((Constants.fullTurnInRadians
                               * Constants.numberOfTurnsOfBallCounterclockwise)
                              - Constants.defaultBallRotation)
        animation.duration = Constants.durationOfAnimationOfBallCounterclockwise
        animation.setupAnimation()
        return animation
    }
    
    private func setupBallAnimationClockwise(with angle: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: AnimationTypes.zRotation.rawValue)
        animation.duration = Constants.ballAnimationClockwiseDuration
        animation.beginTime = Constants.ballAnimationStartTimeClockwise
        animation.toValue = angle
        animation.setupAnimation()
        return animation
    }
    
    // MARK: - get scale of ball
    func getStandardScaleOfBall() -> CGAffineTransform {
        return CGAffineTransform(scaleX: Constants.one, y: Constants.one)
    }
    
    func getIntermediateScaleOfBall() -> CGAffineTransform {
        return CGAffineTransform(scaleX: Constants.intermediateScaleOfBall,
                                 y: Constants.intermediateScaleOfBall)
    }
    
    func ballIdentityTransform() -> CGAffineTransform {
        return CGAffineTransform.identity
    }
    
    func getFinishScaleOfBall() -> CGAffineTransform {
        return CGAffineTransform(scaleX: Constants.finishScaleOfBall,
                                 y: Constants.finishScaleOfBall)
    }
    
    // MARK: - get default ball transform rotated
    func getDefaultBallTransformRotated() -> CGAffineTransform {
        return CGAffineTransform(rotationAngle: -Constants.defaultBallRotation)
    }
    
    func getNumberOfBallBounces() -> Int {
        return numberOfBallBounces
    }
    
    func updateNumberOfBallBounces() {
        numberOfBallBounces += Int(Constants.one)
    }
    
    func resetNumberOfBallBounces() {
        numberOfBallBounces = .zero
    }
}
