//
//  GameModelProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

protocol GameModelProtocol: MainModelProtocol {
    
    func getRandomAngle() -> Double
    func getWinningSector() -> Sector
    func getDefaultSectorLabelText() -> String
}
