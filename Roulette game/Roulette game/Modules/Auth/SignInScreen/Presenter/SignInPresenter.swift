//
//  SignInPresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation

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
            case .success(_): break
            }
        }
    }
    
    func errorWithInputData(error: AuthErrors) {
        switch error {
        case .wrongPassword:
            view?.errorWithInputData(in: .password)
        default: view?.errorWithInputData(in: .allTextFields)
        }
    }
    
    func getText(for textField: TextField, text: String, range: Int) {
        switch textField {
        case .email:
            let email = model.getText(text: text, range: range)
            isValidDataEntry.email = model.isValidEmail(email)
        case .password:
            let password = model.getText(text: text, range: range)
            isValidDataEntry.password = model.isValidPassword(password)
        case .allTextFields: break
        }
    }
    
    func removeLoader() {
        Loader.remove()
    }
}
