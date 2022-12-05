//
//  MainCoordinator.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    
    private var builder: MainModuleBuilderProtocol
    
    var didFinish: VoidCallBlock?
    var navController: UINavigationController
    var childCoordinators: [CoordinatorProtocol]
    var services: Services
    
    init(_ navController: UINavigationController, builder: MainModuleBuilderProtocol, services: Services) {
        self.childCoordinators = []
        self.navController = navController
        self.builder = builder
        self.services = services
    }
    
    func start() {
        showTabBar()
    }
    
    private func showTabBar() {
        let tabBarController = builder.buildTabBarVC()
        let controllers = [getGameVC(), getRatingVC(), getSettingsVC()]
        tabBarController.viewControllers = controllers
        setRoot(tabBarController)
    }
    
    private func getGameVC() -> UINavigationController {
        return builder.buildGamaVC(services: services)
    }
    
    private func getRatingVC() -> UINavigationController {
        return builder.buildRatingVC(services: services)
    }
    
    private func getSettingsVC() -> UINavigationController {
        return builder.buildSettingsVC(services: services)
    }
}
