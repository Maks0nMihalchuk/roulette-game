//
//  SignUpViewController.swift
//  Roulette game
//
//  Created by Максим Михальчук on 04.12.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private enum Constants {
        static let duration: Double = 0.4
        static let buttonCornerRadius: CGFloat = 10
        static let springWithDamping: CGFloat = 0.8
        static let springVelocity: CGFloat = 1
        static let opaque: CGFloat = 1
        static let dotForText = "\u{2022}"
        static let tab = "  "
        static let backButtonImageName = "backArrow"
    }
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var repeatPasswordLabel: UILabel!
    @IBOutlet private weak var repeatPasswordTextField: UITextField!
    @IBOutlet private weak var passwordLenghtLabel: UILabel!
    @IBOutlet private weak var passwordSymbolsLabel: UILabel!
    @IBOutlet private weak var passwordDigitsLabel: UILabel!
    @IBOutlet private weak var passwordLanguageLabel: UILabel!
    @IBOutlet private weak var passwordsMatchLabel: UILabel!
    @IBOutlet private weak var signUpButton: UIButton!
    
    private var scrollViewHelper: ScrollViewHelperProtocol?
    
    var presenter: SignUpPresenterProtocol?

    override func loadView() {
        super.loadView()
        setupNavBarWhenViewIsLoading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupText()
        setupPlaceholders()
        setupTextFields()
        setupSignUpButton()
        setupBackButton()
        setupKeyboardNotifications()
        setupScrollViewHelper()
        hideKeyboardWhenTappedAround()
        changeIsUserInteractionForButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupNavBarForViewWillDisappear()
        presenter?.removeLoader()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction private func didTapSignUpButton(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let userName = userNameTextField.text else { return }
        presenter?.signUpButton(withEmail: email, password: password, userName: userName)
    }
    
    @objc private func didTapBackButton() {
        presenter?.didTapBackButton()
    }
    
    private func changeIsUserInteractionForButton() {
        presenter?.isValidTextBlock = { [weak self] isValidText in
            guard let self = self else { return }
            
            let color: UIColor = isValidText ? .systemBlue : .lightGray
            self.signUpButton.backgroundColor = color
            self.signUpButton.isUserInteractionEnabled = isValidText
        }
    }
}

// MARK: - SignUpViewProtocol
extension SignUpViewController: SignUpViewProtocol {
    
    func showError(with description: String) {
        showErrorAlert(message: description)
    }
    
    func checkPasswordLenght(_ isValid: Bool) {
        passwordLenghtLabel.textColor = changeRequirementLabelsColor(isValid)
    }
    
    func checkPasswordSymbols(_ isValid: Bool) {
        passwordSymbolsLabel.textColor = changeRequirementLabelsColor(isValid)
    }
    
    func checkIfPasswordContainsNumbers(_ isValid: Bool) {
        passwordDigitsLabel.textColor = changeRequirementLabelsColor(isValid)
    }
    
    func checkPasswordLanguage(_ isValid: Bool) {
        passwordLanguageLabel.textColor = changeRequirementLabelsColor(isValid)
    }
    
    func checkPasswordsMatch(_ isValid: Bool) {
        passwordsMatchLabel.textColor = changeRequirementLabelsColor(isValid)
    }
    
    func changeEmailTextFieldBorder(_ isValid: Bool) {
        let color: UIColor = isValid ? .opaqueSeparator : .systemRed
        emailTextField.setBorderColor(with: color)
    }
    
    private func changeRequirementLabelsColor(_ isValid: Bool) -> UIColor {
        return isValid ? .systemGreen : .systemRed
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if textField == userNameTextField {
            changeStatePlaceholderLabel(by: text, placeholder: userNameLabel)
            presenter?.checkUsernameValidity(text)
        } else if textField == emailTextField {
            changeStatePlaceholderLabel(by: text, placeholder: emailLabel)
            presenter?.checkEmailValidity(text)
        } else if textField == passwordTextField {
            let repeatPasswordText = repeatPasswordTextField.text ?? ""
            changeStatePlaceholderLabel(by: text, placeholder: passwordLabel)
            presenter?.isValidPasswords(text, repeatPassword: repeatPasswordText)
        } else if textField == repeatPasswordTextField {
            let passwordText = passwordTextField.text ?? ""
            changeStatePlaceholderLabel(by: text, placeholder: repeatPasswordLabel)
            presenter?.isValidPasswords(passwordText, repeatPassword: text)
        }
    }
    
    private func changeStatePlaceholderLabel(by text: String, placeholder: UILabel) {
        if !text.isEmpty && placeholder.isHidden {
            hidePlaceholderAnimatedly(false, placeholder: placeholder)
        } else if text.isEmpty && !placeholder.isHidden {
            hidePlaceholderAnimatedly(true, placeholder: placeholder)
        }
    }
    
    private func hidePlaceholderAnimatedly(_ isHidden: Bool,
                                           placeholder: UILabel) {
        UIView.animate(withDuration: Constants.duration, delay: .zero,
                       usingSpringWithDamping: Constants.springWithDamping,
                       initialSpringVelocity: Constants.springVelocity,
                       options: .curveEaseOut) {
            placeholder.alpha = isHidden ? .zero : Constants.opaque
            placeholder.isHidden = isHidden
        }
    }
}

// MARK: - Setup scrollViewHelper
private extension SignUpViewController {
    
    func setupScrollViewHelper() {
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

// MARK: - ScrollViewHelperDelegate
extension SignUpViewController: ScrollViewHelperDelegate {
    
    func keyboardAnimation(with animationParameters: AnimationParameters) {
        UIView.animate(withDuration: Constants.duration) {
            self.scrollView.contentInset.bottom = animationParameters.keyboardFrameHeight
        }
    }
}

// MARK: - setup UI
private extension SignUpViewController {
    
    func setupNavBarWhenViewIsLoading() {
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupNavBarForViewWillDisappear() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupBackButton() {
        let imageName = Constants.backButtonImageName
        let button = UIBarButtonItem(image: UIImage(named: imageName), style: .done, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = button
    }
    
    func setupSignUpButton() {
        signUpButton.isUserInteractionEnabled = false
        signUpButton.rounded(Constants.buttonCornerRadius)
        signUpButton.backgroundColor = .lightGray
    }
    
    func setupTextFields() {
        [userNameTextField, emailTextField, passwordTextField, repeatPasswordTextField].forEach {
            $0?.delegate = self
            $0?.setBorderColor(with: .opaqueSeparator)
        }
    }
    
    func setupText() {
        [passwordLenghtLabel, passwordSymbolsLabel, passwordDigitsLabel, passwordLanguageLabel, passwordsMatchLabel].forEach {
            guard let textFieldText = $0?.text else { return }
            let text = Constants.dotForText + Constants.tab + textFieldText
            let attributed = NSMutableAttributedString(string: text)
            $0?.attributedText = attributed
        }
    }
    
    func setupPlaceholders() {
        [userNameLabel, emailLabel, passwordLabel, repeatPasswordLabel].forEach {
            $0?.alpha = .zero
            $0?.isHidden = true
        }
    }
}
