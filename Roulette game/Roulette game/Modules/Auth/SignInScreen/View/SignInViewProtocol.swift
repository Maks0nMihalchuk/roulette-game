//
//  SignInViewProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation

protocol SignInViewProtocol: AnyObject {
    
    func showError(with description: String)
    func errorWithInputData(in textField: TextField)
}
