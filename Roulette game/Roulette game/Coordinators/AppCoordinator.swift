//
//  AppCoordinator.swift
//  Roulette game
//
//  Created by Максим Михальчук on 01.12.2022.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    var window: UIWindow
    var childCoordinators: [CoordinatorProtocol]
    var navController: UINavigationController
    
    init(window: UIWindow) {
        self.childCoordinators = []
        self.navController = UINavigationController()
        self.window = window
        self.window.rootViewController = navController
        self.window.makeKeyAndVisible()
    }
    
    func start() {

    }
    
    private func authFlow() {
        
    }
    
    private func mainFlow() {
        
    }
}
