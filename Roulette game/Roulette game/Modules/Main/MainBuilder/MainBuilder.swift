//
//  MainBuilder.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import UIKit

struct SettingsTransitions {
    let shareApp: BlockWith<[URL]>
}

class MainModuleBuilder: MainModuleBuilderProtocol {
    
    func buildTabBarVC() -> UITabBarController {
        let controller = UITabBarController()
        controller.tabBar.backgroundColor = .white
        return controller
    }
    
    func buildGamaVC(services: Services) -> UINavigationController {
        let controllerID = String(describing: GameViewController.self)
        let model = GameModel(firebaseManager: services.firebaseMainManager)
        let controller = getViewController(controllerID, storyboardName: .Game) as? GameViewController
        
        guard let viewController = controller else {
            fatalError("Couldn’t instantiate view controller with identifier \(controllerID)")
        }
        
        let presenter = GamePresenter(viewController, model: model)
        viewController.presenter = presenter
        
        return configureNavigationController(with: viewController)
    }
    
    func buildRatingVC(services: Services) -> UINavigationController {
        let controllerID = String(describing: RatingViewController.self)
        let model = RatingModel(firebaseManager: services.firebaseMainManager)
        let controller = getViewController(controllerID, storyboardName: .Rating) as? RatingViewController
        
        guard let viewController = controller else {
            fatalError("Couldn’t instantiate view controller with identifier \(controllerID)")
        }
        
        let presenter = RatingPresenter(viewController, model: model)
        viewController.presenter = presenter
        
        return configureNavigationController(with: viewController)
    }
    
    func buildSettingsVC(services: Services, transitions: SettingsTransitions) -> UINavigationController {
        let controllerID = String(describing: SettingViewController.self)
        let model = SettingModel(firebaseManager: services.firebaseMainManager, authService: services.firebaseAuthManager)
        let controller = getViewController(controllerID, storyboardName: .Settings) as? SettingViewController
        
        guard let viewController = controller else {
            fatalError("Couldn’t instantiate view controller with identifier \(controllerID)")
        }
        
        let presenter = SettingPresenter(viewController, model: model,
                                         transitions: transitions)
        viewController.presenter = presenter
        
        return configureNavigationController(with: viewController)
    }
    
    private func configureNavigationController(with controller: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: controller)
    }
}


