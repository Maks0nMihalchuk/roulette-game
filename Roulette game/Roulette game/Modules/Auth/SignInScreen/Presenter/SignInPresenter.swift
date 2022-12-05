//
//  SignInPresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation
import UIKit.UIViewController

class SignInPresenter: SignInPresenterProtocol {
    
    private let loader = Loader(color: .systemBlue)
    private let model: SignInModelProtocol
    private var transitions: SignInTransitions
    private var isValidDataEntry: (email: Bool, password: Bool) = (false, false) {
        didSet {
            let email = isValidDataEntry.email
            let password = isValidDataEntry.password
            self.isValidTextBlock?((email && password) ? true : false)
        }
    }
    
    var isValidTextBlock: ((_ isValidText: Bool) -> Void)?
    
    weak var view: SignInViewProtocol?
    
    init(_ view: SignInViewProtocol, model: SignInModelProtocol, transitions: SignInTransitions) {
        self.view = view
        self.model = model
        self.transitions = transitions
    }
    
    func signIn(with email: String, password: String) {
        let data = SignInRequest(email: email, password: password)
        loader.show()
        model.signIn(with: data) { [weak self] result in
            guard let self = self else { return }
            
            self.loader.hide()

            switch result {
            case .failure(let error):
                self.view?.showError(with: error.description)
                self.errorWithInputData(error: error)
            case .success: break
            }
        }
    }
    
    func signInWithGoogle(presenting: UIViewController) {
        loader.show()
        model.signInWithGoogle(presenting: presenting) { [weak self] result in
            guard let self = self else { return }
            
            self.loader.hide()
            
            switch result {
            case .failure(let error):
                self.view?.showError(with: error.description)
            case .success: break
            }
        }
    }
    
    func signInAnonymously() {
        loader.show()
        model.signInAnonymously { [weak self] result in
            guard let self = self else { return }
            
            self.loader.hide()
            
            switch result {
            case .failure(let error):
                self.view?.showError(with: error.description)
            case .success: break
            }
        }
    }
    
    func didTapSignUpButton() {
        transitions.willRegistration()
    }
    
    func errorWithInputData(error: AuthErrors) {
        switch error {
        case .wrongPassword:
            view?.errorWithInputData(in: .password)
        case .userNotFound:
            view?.errorWithInputData(in: .allTextFields)
        default: break
        }
    }
    
    func checkEmailValidity(_ email: String) {
        isValidDataEntry.email = model.isValidEmail(email)
    }
    
    func checkPasswordValidity(_ password: String) {
        isValidDataEntry.password = model.isValidPassword(password)
    }
    
    func removeLoader() {
        Loader.remove()
    }
}
