//
//  SignUpModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 04.12.2022.
//

import Foundation

class SignUpModel: SignUpModelProtocol {
    
    private let authService: FirebaseAuthManagerProtocol

    init(authService: FirebaseAuthManagerProtocol) {
        self.authService = authService
    }
}
