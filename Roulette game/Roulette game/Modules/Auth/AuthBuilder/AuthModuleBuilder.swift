//
//  AuthBuilder.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation

struct SignInTransitions {
    let forgotPassword: VoidCallBlock
    let willRegistration: VoidCallBlock
    let didAuthorized: VoidCallBlock
}

class AuthModuleBuilder: AuthModuleBuilderProtocol {
    
    func buildSignInVC(transitions: SignInTransitions, services: Services) -> SignInViewController {
        let controllerID = String(describing: SignInViewController.self)
        let model = SignInModel(authService: services.firebaseAuthManager)
        let controller = getViewController(controllerID,
                                           storyboardName: .SignIn) as? SignInViewController
        guard let viewController = controller else {
            fatalError("Couldn’t instantiate view controller with identifier \(controllerID)")
        }
        
        let presenter = SignInPresenter(viewController, model: model,
                                        transitions: transitions)
        viewController.presenter = presenter
        return viewController
    }
    
    func buildSignUpVC() {
        
    }
}
