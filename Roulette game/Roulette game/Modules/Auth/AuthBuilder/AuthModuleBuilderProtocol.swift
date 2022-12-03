//
//  AuthModuleBuilderProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import UIKit

protocol AuthModuleBuilderProtocol: BuilderProtocol {
    
    func buildSignInVC(transitions: SignInTransitions,
                       services: Services) -> SignInViewController
    func buildSignUpVC()
}

