//
//  MainBuilder.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import UIKit

struct SettingsTransitions {
    let shareApp: BlockWith<[URL]>
    let rateApp: VoidCallBlock
}

struct GameTransition {
    let openBettingField: BlockWith<Double>
}

struct BettingFieldTransition {
    
}

class MainModuleBuilder: MainModuleBuilderProtocol {
    
    func buildTabBarVC() -> UITabBarController {
        let controller = UITabBarController()
        controller.tabBar.backgroundColor = .lightGray
        return controller
    }
    
    func buildGameVC(services: Services, transition: GameTransition) -> GameViewController {
        let controllerID = String(describing: GameViewController.self)
        let model = GameModel(firebaseManager: services.firebaseMainManager, authService: services.firebaseAuthManager)
        let controller = getViewController(controllerID, storyboardName: .Game) as? GameViewController
        
        guard let viewController = controller else {
            fatalError("Couldn’t instantiate view controller with identifier \(controllerID)")
        }
        
        let presenter = GamePresenter(viewController,
                                      model: model, transition: transition)
        viewController.presenter = presenter
        viewController.animationManager = services.animationManager
        
        return viewController
    }
    
    func buildBettingFieldVC(bet: Double, transition: BettingFieldTransition, services: Services) -> BettingFieldViewController {
        let controllerID = String(describing: BettingFieldViewController.self)
        let model = BettingFieldModel(bet: bet,
                                      validationService: services.validationManager)
        let controller = getViewController(controllerID, storyboardName: .Game) as? BettingFieldViewController
        
        guard let viewController = controller else {
            fatalError("Couldn’t instantiate view controller with identifier \(controllerID)")
        }
        
        let presenter = BettingFieldPresenter(viewController, model: model, transition: transition)
        let dataSource = BettingFieldDataSource(
            presenter: presenter, 
            bettingField: model.getBettingField()
        )
        viewController.presenter = presenter
        viewController.dataSource = dataSource
        
        return viewController
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


