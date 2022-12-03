//
//  FirebaseAuthManagerProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation
import Firebase

protocol FirebaseAuthManagerProtocol {
    func startAuthorizationObserver(completion: @escaping ((AuthState) -> Void))
    func signIn(with data: SignInRequest,
                completion: @escaping ((Result<Bool, AuthErrors>) -> Void)) 
    func signOut()
}

extension FirebaseAuthManagerProtocol {
    
    func authErrorParsing(from error: Error) -> AuthErrors {
        let errorCode = getAuthErrorCode(from: error)
        let result = AuthErrors.allCases.filter {
            $0.errorCode == errorCode
        }
        return result.first ?? .defaultError
    }
    
    func getAuthErrorCode(from error: Error) -> Int {
        return AuthErrorCode.Code._ErrorType(_nsError: error as NSError).errorCode
    }
}
