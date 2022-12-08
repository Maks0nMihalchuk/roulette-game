//
//  GamePresenterProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

protocol GamePresenterProtocol {
    
    func setIsAnimation(_ isAnimation: Bool)
    func didTapStartButton()
    func getWinningSector()
    func getUserData()
    func removeLoader() 
}
