//
//  SignUpPresenterProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 04.12.2022.
//

import Foundation

protocol SignUpPresenterProtocol {
    
    var isValidTextBlock: ((_ isValidText: Bool) -> Void)? { get set }
    
    func signUpButton(withEmail email: String, password: String, userName: String)
    func checkUsernameValidity(_ userName: String)
    func checkEmailValidity(_ email: String)
    func isValidPasswords(_ password: String, repeatPassword: String)
    
    func didTapBackButton()
    func removeLoader()
}
