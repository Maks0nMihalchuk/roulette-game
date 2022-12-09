//
//  ValidationManager.swift
//  Roulette game
//
//  Created by Максим Михальчук on 04.12.2022.
//

import Foundation

protocol ValidationManagerProtocol {
    func isValidUserName(_ name: String) -> Bool
    func isValidEmail(_ email: String) -> Bool
    func isValidPassword(_ password: String) -> Bool
    func isValidPasswordLength(_ password: String) -> Bool
    func isValidPasswordSymbols(_ password: String) -> Bool
    func isValidPasswordLanguage(_ password: String) -> Bool
    func isValidPasswordDigits(_ password: String) -> Bool
    func isPasswordsMatch(_ password: String, repeatPassword: String) -> Bool
}

class ValidationManager: ValidationManagerProtocol {
    
    private enum RegexType {
        static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d$@$!%*?&#]{8,}$"
        static let passwordLength = "^.{8,}$"
        static let passwordSymbols = "^(?=.*[A-Z]).{1,}$" // "^(?=.*[a-z])(?=.*[A-Z]).{1,}$"
        static let passwordLanguage = "^(?=.*[a-z]).{1,}$"
        static let passwordDigits = "^(?=.*[0-9]).{1,}$"
    }
    
    func isValidUserName(_ name: String) -> Bool {
        return !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func isValidEmail(_ email: String) -> Bool {
        return validation(for: email, with: RegexType.email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return validation(for: password, with: RegexType.password)
    }
    
    func isValidPasswordLength(_ password: String) -> Bool {
        return validation(for: password, with: RegexType.passwordLength)
    }
    
    func isValidPasswordSymbols(_ password: String) -> Bool {
        return validation(for: password, with: RegexType.passwordSymbols)
    }
    
    func isValidPasswordLanguage(_ password: String) -> Bool {
        return validation(for: password, with: RegexType.passwordLanguage)
    }
    
    func isValidPasswordDigits(_ password: String) -> Bool {
        return validation(for: password, with: RegexType.passwordDigits)
    }
    
    func isPasswordsMatch(_ password: String, repeatPassword: String) -> Bool {
        let passwordIsNotNull = !password.trimmingCharacters(in: .whitespaces).isEmpty
        let repeatPasswordIsNotNull = !repeatPassword.trimmingCharacters(in: .whitespaces).isEmpty
        let passwordsIsEqual = password == repeatPassword
        return passwordIsNotNull && repeatPasswordIsNotNull && passwordsIsEqual
    }
    
    private func validation(for text: String,
                            by format: String = "SELF MATCHES %@",
                            with regex: String) -> Bool {
        return NSPredicate(format: format, regex).evaluate(with: text)
    }
}
