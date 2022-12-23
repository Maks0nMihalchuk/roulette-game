//
//  BettingFieldViewController.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import UIKit

class BettingFieldViewController: UIViewController {
    
    private enum Constants {
        static let roundedButton: CGFloat = 15
        static let betAlertRounded: CGFloat = 8
        static let minBetALertViewOffset: CGFloat = 10
        static let one: CGFloat = 1
        static let betAlertViewScale: CGFloat = 1.3
        static let animationDuration = 0.4
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var placeBetButton: UIButton!
    @IBOutlet private weak var betAlertView: BetAlertView!
    @IBOutlet private weak var visualEffectView: UIVisualEffectView!
    @IBOutlet private weak var betAlertViewVerticalConstraint: NSLayoutConstraint!
    
    private var scrollViewHelper: ScrollViewHelperProtocol?
    var presenter: BettingFieldPresenterProtocol?
    var dataSource: BettingFieldDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSctollViewHelper()
        setupKeyboardNotifications()
        hideKeyboardWhenTappedAround()
        setupPlaceBetButton()
        setupCollectionView()
        presenter?.setupBetAlert()
        addTapGestureForVisualEffectView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction private func didTapPlaceBetButton(_ sender: UIButton) {
        print("didTapPlaceBetButton")
    }
    
    @objc private func didTapToHideBetAlertView() {
        betAlertView.hideKeyboard()
        hideBetAlertView()
    }
}

// MARK: - BettingFieldViewProtocol
extension BettingFieldViewController: BettingFieldViewProtocol {
    
    func showBetAlertView() {
        betAlertView.transform = CGAffineTransform(
            scaleX: Constants.betAlertViewScale,
            y: Constants.betAlertViewScale
        )
        betAlertView.alpha = .zero
        self.visualEffectView.isHidden = false
        self.betAlertView.isHidden = false
        
        UIView.animate(withDuration: Constants.animationDuration) {
            self.visualEffectView.alpha = Constants.one
            self.betAlertView.alpha = Constants.one
            self.betAlertView.transform = .identity
        }
    }
    
    func hideBetAlertView() {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.betAlertView.alpha = .zero
            self.visualEffectView.alpha = .zero
            self.betAlertView.transform = CGAffineTransform(
                scaleX: Constants.betAlertViewScale,
                y: Constants.betAlertViewScale
            )
        } completion: { _ in
            self.betAlertView.transform = .identity
            self.visualEffectView.isHidden = true
            self.betAlertView.isHidden = true
        }
    }
    
    func setupBetAlert(with dataModel: BetAlertViewDataModel) {
        betAlertView.rounded(Constants.betAlertRounded)
        betAlertView.setupView(with: dataModel, textFieldDelegate: self)
    }
    
    func isErrorInEnteredBet(_ isError: Bool) {
        betAlertView.isErrorInEnteredBet(isError)
    }
}

// MARK: - UITextFieldDelegate
extension BettingFieldViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.isEmpty {
            betAlertView.setDefaultTextFieldBorderColor()
            return
        }
        
        presenter?.isValidEnteredBet(text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.isEmpty {
            betAlertView.setDefaultTextFieldBorderColor()
        }
    }
}

// MARK: - ScrollViewHelperDelegate
extension BettingFieldViewController: ScrollViewHelperDelegate {
    
    func keyboardAnimation(with animationParameters: AnimationParameters) {
        var betAlertViewOffset = CGFloat.zero
        
        if animationParameters.keyboardFrameHeight != .zero {
            let keyboardOriginMinY = self.view.bounds.height - animationParameters.keyboardFrameHeight
            let betAlertViewMaxY = self.betAlertView.frame.maxY
            let isCalculateOffset = (keyboardOriginMinY < betAlertViewMaxY)
            
            if isCalculateOffset {
                betAlertViewOffset = (keyboardOriginMinY - betAlertViewMaxY) - Constants.minBetALertViewOffset
            }
        }

        UIView.animate(withDuration: animationParameters.duration) {
            self.betAlertViewVerticalConstraint.constant = betAlertViewOffset
        }
    }
}

// MARK: - setup UI
private extension BettingFieldViewController {
    
    func setupPlaceBetButton() {
        placeBetButton.rounded(Constants.roundedButton)
    }
    
    func addTapGestureForVisualEffectView() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapToHideBetAlertView)
        )
        visualEffectView.addGestureRecognizer(tap)
    }
    
    func setupCollectionView() {
        guard let dataSource = dataSource else { return }
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.collectionViewLayout = dataSource.setupCollectionViewLayout()
        collectionView.regiserCellByClass(
            cellClass: NumberCollectionViewCell.self
        )
        collectionView.regiserCellByClass(
            cellClass: OuterCollectionViewCellWithText.self
        )
        collectionView.regiserCellByClass(
            cellClass: OuterCollectionViewCellWithImage.self
        )
    }
    
    func setupSctollViewHelper() {
        scrollViewHelper = ScrollViewHelper()
        scrollViewHelper?.delegate = self
    }
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        scrollViewHelper?.keyboardWillShow(notification)
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        scrollViewHelper?.keyboardWillHide(notification)
    }
    
    @objc func keyboardWillChangeFrame(_ notification: NSNotification) {
        scrollViewHelper?.keyboardWillChangeFrame(notification)
    }
}
