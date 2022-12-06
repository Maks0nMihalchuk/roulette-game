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
    var settingViewController: UINavigationController?
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
        let controller = builder.buildGamaVC(services: services)
        controller.navigationBar.isHidden = true
        return controller
    }
    
    private func getRatingVC() -> UINavigationController {
        let controller = builder.buildRatingVC(services: services)
        controller.navigationBar.isHidden = true
        return controller
    }
    
    private func getSettingsVC() -> UINavigationController {
        let transitions = SettingsTransitions { [weak self] data in
            self?.shareApp(with: data)
        }
        let controller = builder.buildSettingsVC(services: services, transitions: transitions)
        controller.navigationBar.isHidden = true
        self.settingViewController = controller
        return controller
    }
    
    private func shareApp(with data: [URL]) {
        let controller = UIActivityViewController(activityItems: data, applicationActivities: nil)
        self.settingViewController?.present(controller, animated: true)
    }
}
