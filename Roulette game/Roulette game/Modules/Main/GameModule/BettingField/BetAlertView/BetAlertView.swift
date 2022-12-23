//
//  BetAlertView.swift
//  Roulette game
//
//  Created by Максим Михальчук on 20.12.2022.
//

import UIKit

class BetAlertView: UIView {
    
    private enum Constants {
        static let contentViewRounded: CGFloat = 8
        static let buttonRounded: CGFloat = 10
        static let aniumateDuration = 0.4
        static let one: CGFloat = 1
    }

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var betTextField: UITextField!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var betButton: UIButton!
    
    private var dataModel: BetAlertViewDataModel? {
        didSet {
            guard let _ = dataModel else { return }
            
            setupView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadViewFromNib()
    }
    
    func hideKeyboard() {
        betTextField.resignFirstResponder()
    }
    
    func isErrorInEnteredBet(_ isError: Bool) {
        print("isError: \(isError)")
        isHiddenErrorLabel(!isError)
        setTextFieldBorderColor(isError)
    }
    
    func setDefaultTextFieldBorderColor() {
        betTextField.setBorderColor(with: .opaqueSeparator)
        isHiddenErrorLabel(true)
    }
    
    func setupView(with model: BetAlertViewDataModel,
                   textFieldDelegate: UITextFieldDelegate) {
        self.dataModel = model
        self.betTextField.delegate = textFieldDelegate
    }
    
    private func setupView() {
        headerLabel.text = dataModel?.headerText
        errorLabel.text = dataModel?.errorText
        errorLabel.isHidden = true
//        errorLabel.alpha = .zero
        betTextField.placeholder = dataModel?.textFieldPlaceholder
        betTextField.setBorderColor(with: .opaqueSeparator)
        betTextField.keyboardType = .decimalPad
        contentView.rounded(Constants.contentViewRounded)
        betButton.rounded(Constants.buttonRounded)
        cancelButton.rounded(Constants.buttonRounded)
    }
    
    private func isHiddenErrorLabel(_ isHidden: Bool) {
        self.errorLabel.isHidden = isHidden
    }
    
    private func setTextFieldBorderColor(_ isColor: Bool) {
        let color = isColor
        ? (UIColor(named: "redColor") ?? .systemRed)
        : (UIColor(named: "greenColor") ?? .systemGreen)
        betTextField.setBorderColor(with: color)
    }
    
    @IBAction private func didTapCancelButton(_ sender: UIButton) {
        guard let action = dataModel?.cancelAction else { return }
        action()
    }
    
    @IBAction private func didTapBetButton(_ sender: UIButton) {
        guard let action = dataModel?.betAction, let text = betTextField.text else { return }
        action(text)
    }
}
