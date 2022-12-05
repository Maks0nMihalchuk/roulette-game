//
//  SignUpPresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 04.12.2022.
//

import Foundation
import UIKit.UIColor

class SignUpPresenter: SignUpPresenterProtocol {
    
    private let loader = Loader(color: .systemBlue)
    private let model: SignUpModelProtocol
    private var transitions: SignUpTransitions
    
    weak var view: SignUpViewProtocol?
    
    private var isValidDataEntry: (userName: Bool, email: Bool, password: Bool) = (false, false, false) {
        didSet {
            let userName = isValidDataEntry.userName
            let email = isValidDataEntry.email
            let password = isValidDataEntry.password
            
            let isValid = userName && email && password
            self.isValidTextBlock?((isValid) ? true : false)
        }
    }
    
    var isValidTextBlock: ((_ isValidText: Bool) -> Void)?
    
    init(_ view: SignUpViewProtocol, model: SignUpModelProtocol, transitions: SignUpTransitions) {
        self.view = view
        self.model = model
        self.transitions = transitions
    }
    
    func signUpButton(withEmail email: String, password: String, userName: String) {
        loader.show()
        model.signUp(withEmail: email, password: password, userName: userName) { [weak self] result in
            guard let self = self else { return }
            
            self.loader.hide()
            switch result {
            case .failure(let error):
                self.view?.showError(with: error.description)
            case .success: break
            }
        }
    }
    
    func didTapBackButton() {
        transitions.didBack()
    }
    
    func checkUsernameValidity(_ userName: String) {
        isValidDataEntry.userName = model.isValidUserName(userName)
    }
    
    func checkEmailValidity(_ email: String) {
        isValidDataEntry.email = model.isValidEmail(email)
    }
    
    func isValidPasswords(_ password: String, repeatPassword: String) {
        let isValidPasswordLength = model.isValidPasswordLength(password)
        let isValidPasswordSymbols = model.isValidPasswordSymbols(password)
        let isValidPasswordLanguage = model.isValidPasswordLanguage(password)
        let isValidPasswordDigits = model.isValidPasswordDigits(password)
        let isPasswordsMatch = model.isPasswordsMatch(password, repeatPassword: repeatPassword)
        
        let isValidPassword = model.isValidPassword(password)
        isValidDataEntry.password = isValidPassword && isPasswordsMatch
        
        view?.checkPasswordLenght(isValidPasswordLength)
        view?.checkPasswordSymbols(isValidPasswordSymbols)
        view?.checkPasswordLanguage(isValidPasswordLanguage)
        view?.checkIfPasswordContainsNumbers(isValidPasswordDigits)
        view?.checkPasswordsMatch(isPasswordsMatch)
    }
    
    func removeLoader() {
        Loader.remove()
    }
}
