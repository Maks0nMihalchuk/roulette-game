//
//  GameViewController.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    private enum Constants {
        static let roundedButton: CGFloat = 15
        static let roundedHeaderView: CGFloat = 20
        static let viewShadowOffset: CGSize = CGSize(width: 1, height: 4)
        static let viewShadowRadius: CGFloat = 5
        static let viewShadowOpacity: Float = 0.6
        static let stepDevider: Int = 10
        static let maxNumberOfJumps = 1
    }
    
    @IBOutlet private weak var backgroundHeaderView: UIView!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userBalanceLabel: UILabel!
    @IBOutlet private weak var sectorPlaceholderLabel: UILabel!
    @IBOutlet private weak var sectorLabel: UILabel!
    @IBOutlet private weak var stepper: UIStepper!
    @IBOutlet private weak var betAmount: UILabel!
    @IBOutlet private weak var selectedBet: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var rouletteImageView: UIImageView!
    @IBOutlet private weak var ballImageView: UIImageView!
    @IBOutlet private weak var openBettingFieldButton: UIButton!
    
    var presenter: GamePresenterProtocol?
    var animationManager: AnimationManagerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupStartButton()
        setupOpenBettingFieldButton()
        setupBallImageView()
        presenter?.getUserData()
//        presenter?.isDisableStartButton(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.removeLoader()
    }
    
    @IBAction private func didTapStartButton(_ sender: UIButton) {
        presenter?.didTapStartButton()
    }
    
    @IBAction private func didTapStepper(_ sender: UIStepper) {
        betAmount.text = String(stepper.value)
        presenter?.setBet(bet: stepper.value)
    }
    
    @IBAction private func didTapOpenBettingFieldButton(_ sender: UIButton) {
        let bet = stepper.value
        
        presenter?.didTapOpenBettingFieldView(with: bet)
        
    }

    private func ballTransform() {
        guard let animationManager = animationManager else { return }
        animationManager.ballTransform {
            self.ballImageView.transform = animationManager.getIntermediateScaleOfBall()
        } completion: { finished in
            self.ballSpringAnimation()
        }
    }
    
    private func ballSpringAnimation() {
        guard let animationManager = animationManager else { return }
        
        animationManager.springAnimate { [weak self] in
            self?.ballImageView.transform = animationManager.ballIdentityTransform()
            self?.ballImageView.transform = animationManager.getFinishScaleOfBall()
        } animations: { [weak self] in
            self?.ballImageView.transform = animationManager.ballIdentityTransform()
            self?.ballImageView.transform = animationManager.getFinishScaleOfBall()
        } completion: { [weak self] finished in
            if animationManager.getNumberOfBallBounces()
                < Constants.maxNumberOfJumps {
                self?.ballSpringAnimation()
            } else {
                self?.presenter?.getWinningSector()
                self?.presenter?.setIsAnimation(false)
            }
            animationManager.updateNumberOfBallBounces()
        }
    }
}

// MARK: - GameViewProtocol
extension GameViewController: GameViewProtocol {
    
    func showError(_ message: String) {
        showErrorAlert(message: message)
    }
    
    func startAnimation(with angle: Double) {
        guard let animationManager = animationManager else { return }
        
        animationManager.resetNumberOfBallBounces()
        ballImageView.transform = animationManager.getStandardScaleOfBall()
        removeAllAnimations()
        rouletteImageView.addAnimation(animationManager.getRouletteAnimation(),
                                       forKey: .animation)
        ballImageView.addAnimation(animationManager.getBallAnimations(with: angle),
                                   forKey: .animation)
        ballTransform()
    }
    
    func isDisableStartButton(_ isDisable: Bool) {
        startButton.isDisable(isDisable)
    }
    
    func isDisableActions(_ isDisable: Bool) {
        
        startButton.isDisable(isDisable)
        stepper.isDisable(isDisable)
        openBettingFieldButton.isDisable(isDisable)
    }
    
    func setTextInSectorLabel(_ text: String) {
        sectorLabel.text = text
    }
    
    func getUserName(_ name: String) {
        userNameLabel.text = name
    }
    
    func getUserCurrentBalance(_ balance: Int) {
        userBalanceLabel.text = String(balance)
        stepper.stepValue = Double(balance / Constants.stepDevider)
        stepper.maximumValue = Double(balance)
    }
    
    func setBetAmount(_ amount: Double) {
        betAmount.text = String(amount)
    }
}

// MARK: - setup UI
private extension GameViewController {
    
    func setupHeaderView() {
        backgroundHeaderView.rounded(Constants.roundedHeaderView)
        backgroundHeaderView.settingShadow(color: .darkGray, offset: Constants.viewShadowOffset, radius: Constants.viewShadowRadius, opacity: Constants.viewShadowOpacity)
    }
    
    func setupStartButton() {
        startButton.rounded(Constants.roundedButton)
    }
    
    func setupOpenBettingFieldButton() {
        openBettingFieldButton.rounded(Constants.roundedButton)
    }
    
    func setupBallImageView() {
        guard let animationManager = animationManager else { return }
        ballImageView.transform = animationManager.getDefaultBallTransformRotated()
    }
    
    func removeAllAnimations() {
        guard let animationManager = animationManager else { return }
        
        rouletteImageView.layer.removeAllAnimations()
        ballImageView.layer.removeAnimation(forKey: AnimationTypes.animation.rawValue)
        ballImageView.transform = animationManager.getStandardScaleOfBall()
    }
}
