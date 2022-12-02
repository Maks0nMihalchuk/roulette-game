//
//  AuthCoordinator.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import UIKit

final class AuthCoordinator: CoordinatorProtocol {
    
    private var builder: AuthModuleBuilderProtocol
    
    var navController: UINavigationController
    var childCoordinators: [CoordinatorProtocol]
    
    init(_ navController: UINavigationController, builder: AuthModuleBuilderProtocol) {
        self.childCoordinators = []
        self.navController = navController
        self.builder = builder
    }
    
    func start() {
        signIn()
    }
    
    private func signIn() {
        let transitions = SignInTransitions {
            print("forgotPassword")
        } willRegistration: {
            print("willRegistration")
        } didAuthorized: {
            print("didAuthorized")
        }
        
        let controller = builder.buildSignInVC(transitions: transitions)
        setRoot(controller)
    }
}
