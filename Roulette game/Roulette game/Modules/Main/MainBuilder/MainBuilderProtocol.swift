//
//  MainBuilderProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import UIKit

protocol MainModuleBuilderProtocol: BuilderProtocol {
    
    func buildTabBarVC() -> UITabBarController
    func buildGamaVC(services: Services) -> UINavigationController
    func buildRatingVC(services: Services) -> UINavigationController
    func buildSettingsVC(services: Services,
                         transitions: SettingsTransitions) -> UINavigationController
}
