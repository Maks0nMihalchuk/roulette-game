//
//  SignUpModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 04.12.2022.
//

import Foundation

class SignUpModel: SignUpModelProtocol {
    
    private let authService: FirebaseAuthManagerProtocol
    private let validationManager: ValidationManagerProtocol

    init(authService: FirebaseAuthManagerProtocol, validationManager: ValidationManagerProtocol) {
        self.authService = authService
        self.validationManager = validationManager
    }
    
    func signUp(withEmail email: String, password: String, userName: String, completion: @escaping (Resulter<RegistrationError>) -> Void) {
        authService.signUp(withEmail: email, password: password, userName: userName) { result in
            completion(result)
        }
    }
    
    func isValidUserName(_ userName: String) -> Bool {
        return validationManager.isValidUserName(userName)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        return validationManager.isValidEmail(email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return validationManager.isValidPassword(password)
    }
    
    func isValidPasswordLength(_ password: String) -> Bool {
        return validationManager.isValidPasswordLength(password)
    }
    
    func isValidPasswordSymbols(_ password: String) -> Bool {
        return validationManager.isValidPasswordSymbols(password)
    }
    
    func isValidPasswordLanguage(_ password: String) -> Bool {
        return validationManager.isValidPasswordLanguage(password)
    }
    
    func isValidPasswordDigits(_ password: String) -> Bool {
        return validationManager.isValidPasswordDigits(password)
    }
    
    func isPasswordsMatch(_ password: String, repeatPassword: String) -> Bool {
        return validationManager.isPasswordsMatch(password, repeatPassword: repeatPassword)
    }
}
