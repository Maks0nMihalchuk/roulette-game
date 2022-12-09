//
//  SignInModelProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation
import UIKit.UIViewController

protocol SignInModelProtocol {
    func signIn(with data: SignInRequest, completion: @escaping ((Resulter<AuthErrors>) -> Void))
    func signInWithGoogle(presenting: UIViewController, completion: @escaping ((Resulter<AuthErrors>) -> Void))
    func signInAnonymously(completion: @escaping ((Resulter<AuthErrors>) -> Void))

    func isValidPassword(_ password: String) -> Bool    
    func isValidEmail(_ email: String) -> Bool
}
