//
//  AuthCoordinator.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import UIKit

final class AuthCoordinator: CoordinatorProtocol {
    
    private var builder: AuthModuleBuilderProtocol
    
    var didFinish: VoidCallBlock?
    var navController: UINavigationController
    var childCoordinators: [CoordinatorProtocol]
    var services: Services
    
    init(_ navController: UINavigationController, builder: AuthModuleBuilderProtocol, services: Services) {
        self.childCoordinators = []
        self.navController = navController
        self.builder = builder
        self.services = services
    }
    
    func start() {
        services.firebaseAuthManager.startAuthorizationObserver { [weak self] state in
            switch state {
            case .main:
                self?.didFinish?()
            case .auth: self?.signIn()
            }
        }
    }
    
    private func signIn() {
        let transitions = SignInTransitions { [weak self] in
            self?.signUp()
        }
        
        let controller = builder.buildSignInVC(transitions: transitions,
                                               services: services)
        setRoot(controller)
    }
    
    private func signUp() {
        let transitions = SignUpTransitions {
            self.pop()
        }
        let controller = builder.buildSignUpVC(transitions: transitions, services: services)
        push(controller)
    }
}
