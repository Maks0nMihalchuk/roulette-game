//
//  FirebaseAuthManagerProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation
import Firebase
import UIKit.UIViewController

enum Resulter<T> {
    case success
    case failure(T)
}

struct FirebaseError<T> {
    let error: T
}

protocol FirebaseAuthManagerProtocol {
    func startAuthorizationObserver(completion: @escaping ((UserFlow) -> Void))
    func signIn(with data: SignInRequest, completion: @escaping ((Resulter<AuthErrors>) -> Void))
    func signInWithGoogle(presenting: UIViewController, completion: @escaping ((Resulter<AuthErrors>) -> Void))
    func signInAnonymously(completion: @escaping ((Resulter<AuthErrors>) -> Void))
    func signOut()
    
    func signUp(withEmail email: String, password: String, userName: String, completion: @escaping ((Resulter<RegistrationError>) -> Void))
}

extension FirebaseAuthManagerProtocol {
    
    func errorParsing<T>(_ error: Error, type: T.Type) -> FirebaseError<T>? {
        let errorCode = getErrorCode(error)
        
        if let result = AuthErrors.allCases.filter({ $0.errorCode == errorCode }).first {
            return FirebaseError<T>(error: result as! T)
        } else if let result = RegistrationError.allCases.filter({$0.errorCode == errorCode}).first {
            return FirebaseError<T>(error: result as! T)
        } else if let result = GoogleErrors.allCases.filter({$0.errorCode == errorCode}).first {
            return FirebaseError<T>(error: result as! T)
        }
        return nil
    }
    
    private func getErrorCode(_ error: Error) -> Int {
        return (error as NSError).code
    }
}
