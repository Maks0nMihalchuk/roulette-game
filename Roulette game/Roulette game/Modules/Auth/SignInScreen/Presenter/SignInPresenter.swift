//
//  SignInPresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation

class SignInPresenter: SignInPresenterProtocol {
    
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
    
    func getText(for textField: TextField, text: String, range: Int) {
        switch textField {
        case .email:
            let email = model.getText(text: text, range: range)
            isValidDataEntry.email = model.isValidEmail(email)
        case .password:
            let password = model.getText(text: text, range: range)
            isValidDataEntry.password = model.isValidPassword(password)
        }
    }
}
