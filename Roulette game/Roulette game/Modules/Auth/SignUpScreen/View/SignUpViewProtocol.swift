//
//  SignUpViewProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 04.12.2022.
//

import Foundation

protocol SignUpViewProtocol: AnyObject {
    
//    func passwordMismatch(_ message: String)    
    func checkPasswordLenght(_ isValid: Bool)
    func checkPasswordSymbols(_ isValid: Bool)
    func checkIfPasswordContainsNumbers(_ isValid: Bool)
    func checkPasswordLanguage(_ isValid: Bool)
    func checkPasswordsMatch(_ isValid: Bool)
}
