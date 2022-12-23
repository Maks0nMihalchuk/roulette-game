//
//  MainBuilderProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import UIKit

protocol MainModuleBuilderProtocol: BuilderProtocol {
    
    func buildTabBarVC() -> UITabBarController
    func buildGameVC(services: Services,
                     transition: GameTransition) -> GameViewController
    func buildBettingFieldVC(bet: Double, transition: BettingFieldTransition, services: Services) -> BettingFieldViewController
    func buildRatingVC(services: Services) -> UINavigationController
    func buildSettingsVC(services: Services,
                         transitions: SettingsTransitions) -> UINavigationController
}
