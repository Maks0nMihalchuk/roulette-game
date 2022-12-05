//
//  SignUpModelProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 04.12.2022.
//

import Foundation

protocol SignUpModelProtocol {
    
    func signUp(withEmail email: String, password: String, userName: String, completion: @escaping BlockWith<Result<Bool, AuthErrors>>)
    
    func isValidUserName(_ userName: String) -> Bool
    func isValidEmail(_ email: String) -> Bool
    func isValidPassword(_ password: String) -> Bool
    func isValidPasswordLength(_ password: String) -> Bool
    func isValidPasswordSymbols(_ password: String) -> Bool
    func isValidPasswordLanguage(_ password: String) -> Bool
    func isValidPasswordDigits(_ password: String) -> Bool
    func isPasswordsMatch(_ password: String, repeatPassword: String) -> Bool
}
