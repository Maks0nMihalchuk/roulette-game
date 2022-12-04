//
//  SignInViewController.swift
//  Roulette game
//
//  Created by Максим Михальчук on 01.12.2022.
//

import UIKit

class SignInViewController: UIViewController {
    
    private enum Constants {
        static let duration: Double = 0.4
        static let buttonCornerRadius: CGFloat = 10
        static let springWithDamping: CGFloat = 0.8
        static let springVelocity: CGFloat = 1
        static let opaque: CGFloat = 1
    }
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var emailPlaceholderLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordPlaceholderLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var signInWithGoogleButton: UIButton!
    @IBOutlet private weak var signInWithAnonymousButton: UIButton!
    @IBOutlet private weak var registrationButton: UIButton!
    
    private var scrollViewHelper: ScrollViewHelperProtocol?
    
    var presenter: SignInPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        changeIsUserInteractionForButton()
        hideKeyboardWhenTappedAround()
        setupKeyboardNotifications()
        setupScrollViewHelper()
        setupPlaceholders()
        setupButtons()
        setupTextFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.removeLoader()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction private func didTapSignInButton(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else { return }
        presenter?.signIn(with: email, password: password)
    }
    
    @IBAction private func didTapSignInWithGoogleButton(_ sender: UIButton) {
        presenter?.signInWithGoogle(presenting: self)
    }
    
    @IBAction private func didTapSignInWithAnonymousButton(_ sender: Any) {
        
    }
    
    @IBAction private func didTapRegistrationButton(_ sender: Any) {
        
    }
    
    private func changeIsUserInteractionForButton() {
        presenter?.isValidTextBlock = { [weak self] isValidText in
            guard let self = self else { return }
            
            let color: UIColor = isValidText ? .systemBlue : .lightGray
            self.signInButton.backgroundColor = color
            self.signInButton.isUserInteractionEnabled = isValidText
            self.changeTextFiledsState(false)
        }
    }
}

// MARK: - SignInViewProtocol
extension SignInViewController: SignInViewProtocol {
    
    func showError(with description: String) {
        showErrorAlert(message: description)
    }
    
    func errorWithInputData(in textField: TextField) {
        switch textField {
        case .password:
            passwordTextField.setBorderColor(with: .red)
        case .email:
            emailTextField.setBorderColor(with: .red)
        case .allTextFields:
            changeTextFiledsState(true)
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        let fullText = text + string
        
        if textField == emailTextField {
            presenter?.getText(for: .email, text: fullText, range: range.length)
        } else {
            presenter?.getText(for: .password, text: fullText, range: range.length)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if textField == emailTextField {
            changeStatePlaceholderLabel(by: text,
                                        placeholder: emailPlaceholderLabel)
        } else {
            changeStatePlaceholderLabel(by: text,
                                        placeholder: passwordPlaceholderLabel)
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
    
    private func changeTextFiledsState(_ state: Bool) {
        let color: UIColor = state ? .red : .opaqueSeparator
        emailTextField.setBorderColor(with: color)
        passwordTextField.setBorderColor(with: color)
    }
}

// MARK: - ScrollViewHelperDelegate
extension SignInViewController: ScrollViewHelperDelegate {
    
    func keyboardAnimation(with animationParameters: AnimationParameters) {
        UIView.animate(withDuration: Constants.duration) {
            self.scrollView.contentInset.bottom = animationParameters.keyboardFrameHeight
        }
    }
}

// MARK: - Setup scrollViewHelper
private extension SignInViewController {
    
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

// MARK: Setup UI
private extension SignInViewController {
    
    func setupPlaceholders() {
        emailPlaceholderLabel.isHidden = true
        emailPlaceholderLabel.alpha = .zero
        passwordPlaceholderLabel.isHidden = true
    }
    
    func setupButtons() {
        [signInButton, signInWithGoogleButton, signInWithAnonymousButton].forEach {
            $0?.rounded(Constants.buttonCornerRadius)
        }
        signInButton.isUserInteractionEnabled = false
    }
    
    func setupTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.setBorderColor(with: .opaqueSeparator)
        passwordTextField.setBorderColor(with: .opaqueSeparator)
    }
}
