//
//  SignInModelProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation

protocol SignInModelProtocol {
    
    var emailText: String { get set }
    var passwordText: String { get set }
    
    func getText(text: String, range: Int) -> String
    func isValidPassword(_ password: String) -> Bool    
    func isValidEmail(_ email: String) -> Bool
}
