//
//  SignInModelProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation
import UIKit.UIViewController

protocol SignInModelProtocol {
    func signIn(with data: SignInRequest, completion: @escaping ((Result<Bool, AuthErrors>) -> Void))
    func signInWithGoogle(presenting: UIViewController, completion: @escaping ((Result<Bool, AuthErrors>) -> Void))
    func signInAnonymously(completion: @escaping ((Result<Bool, AuthErrors>) -> Void))

    func getText(text: String, range: Int) -> String
    func isValidPassword(_ password: String) -> Bool    
    func isValidEmail(_ email: String) -> Bool
}
