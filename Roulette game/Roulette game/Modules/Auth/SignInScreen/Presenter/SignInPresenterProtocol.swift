//
//  SignInPresenterProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation
import UIKit.UIViewController

protocol SignInPresenterProtocol {
    var isValidTextBlock: ((_ isValidText: Bool) -> Void)? { get set }
    
    func signIn(with email: String, password: String)
    func signInWithGoogle(presenting: UIViewController)
    func signInAnonymously()
    func didTapSignUpButton()
    func getText(for textField: TextField, text: String, range: Int)
    
    func removeLoader()
}
