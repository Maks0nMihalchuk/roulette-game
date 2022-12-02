//
//  CoordinatorProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 01.12.2022.
//

import UIKit

typealias VoidCallBlock = (() -> Void)
typealias BlockWith<T> = ((T) -> Void)

protocol CoordinatorProtocol: AnyObject {
    var navController: UINavigationController { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    func addChildCoordinator(_ coordinator: CoordinatorProtocol)
    func start()
}

// MARK: - Additional functionality
extension CoordinatorProtocol {

    func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.forEach { if $0 === coordinator { return } }
        childCoordinators.append(coordinator)
    }

    func setRoot(_ viewController: UIViewController, animated: Bool = true) {
        self.navController.navigationBar.isHidden = true
        self.navController.setViewControllers([viewController], animated: animated)
    }

    func push(_ viewController: UIViewController, animated: Bool = true) {
        self.navController.pushViewController(viewController, animated: animated)
    }

    func pop(animated: Bool = true) {
        self.navController.popViewController(animated: animated)
    }
}
