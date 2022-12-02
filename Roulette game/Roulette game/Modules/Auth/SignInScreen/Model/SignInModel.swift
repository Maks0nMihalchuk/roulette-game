//
//  SignInModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation

enum TextField {
    case email
    case password
}

class SignInModel: SignInModelProtocol {
    
    private enum Constants {
        static let passwordCount = 8
        static let defaultRange = 1
    }
    
    var emailText = String()
    var passwordText = String()
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= Constants.passwordCount
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func getText(text: String, range: Int) -> String {
        if range >= Constants.defaultRange {
            var resultString = text

            (.zero..<range).forEach {_ in resultString.removeLast() }

            return  resultString
        } else {
            return text
        }
    }
}
