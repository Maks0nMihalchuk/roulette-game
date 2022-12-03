//
//  AppCoordinator.swift
//  Roulette game
//
//  Created by Максим Михальчук on 01.12.2022.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    var services: Services
    var window: UIWindow
    var childCoordinators: [CoordinatorProtocol]
    var navController: UINavigationController
    
    init(window: UIWindow) {
        self.childCoordinators = []
        self.services = Services()
        self.navController = UINavigationController()
        self.window = window
        self.window.rootViewController = navController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        services.firebaseAuthManager.signOut()
        authFlow()
    }
    
    private func authFlow() {
        let builder = AuthModuleBuilder()
        let authCoordinator = AuthCoordinator(navController, builder: builder, services: services)
        self.addChildCoordinator(authCoordinator)
        authCoordinator.didFinish = { [weak self] in
            self?.removeChildCoordinator(coordinator: authCoordinator)
            self?.mainFlow()
        }
        authCoordinator.start()
    }
    
    private func mainFlow() {
        print("start main flow")
    }
}
