//
//  SignInModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation
import UIKit.UIViewController

enum TextField {
    case email
    case password
    case allTextFields
}

struct SignInRequest {
    let email: String
    let password: String
}

class SignInModel: SignInModelProtocol {
    
    private var authService: FirebaseAuthManagerProtocol
    private var validationManager: ValidationManagerProtocol
    
    init(authService: FirebaseAuthManagerProtocol,
         validationManager: ValidationManagerProtocol) {
        self.validationManager = validationManager
        self.authService = authService
    }
    
    func signIn(with data: SignInRequest,
                completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
        authService.signIn(with: data) { result in
            completion(result)
        }
    }
    
    func signInWithGoogle(presenting: UIViewController, completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
        authService.signInWithGoogle(presenting: presenting) {result in
            completion(result)
        }
    }
    
    func signInAnonymously(completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
        authService.signInAnonymously { result in
            completion(result)
        }
    }

    func isValidPassword(_ password: String) -> Bool {
        return validationManager.isValidPasswordLength(password)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        return validationManager.isValidEmail(email)
    }
    
//    func getText(text: String, range: Int) -> String {
//        if range >= Constants.defaultRange {
//            var resultString = text
//
//            (.zero..<range).forEach {_ in resultString.removeLast() }
//
//            return  resultString
//        } else {
//            return text
//        }
//    }
}
