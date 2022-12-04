//
//  FirebaseAuthManagerProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation
import Firebase
import UIKit.UIViewController

protocol FirebaseAuthManagerProtocol {
    func startAuthorizationObserver(completion: @escaping ((UserFlow) -> Void))
    func signIn(with data: SignInRequest,
                completion: @escaping ((Result<Bool, AuthErrors>) -> Void))
    func signInWithGoogle(presenting: UIViewController, completion: @escaping ((Result<Bool, AuthErrors>) -> Void))
    func signInAnonymously(completion: @escaping ((Result<Bool, AuthErrors>) -> Void))
    func signOut()
}

extension FirebaseAuthManagerProtocol {
    
    func firebaseAuthErrorParsing(from error: Error) -> AuthErrors {
        let errorCode = getFirebaseAuthErrorCode(from: error)
        let result = AuthErrors.allCases.filter {
            $0.errorCode == errorCode
        }
        return result.first ?? .defaultError
    }
    
    func getFirebaseAuthErrorCode(from error: Error) -> Int {
        return AuthErrorCode.Code._ErrorType(_nsError: error as NSError).errorCode
    }
    
    func googleAuthErrorParsing(from error: Error) {
        
    }
}
