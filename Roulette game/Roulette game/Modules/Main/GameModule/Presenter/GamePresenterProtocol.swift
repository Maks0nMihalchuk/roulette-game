//
//  GamePresenterProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

protocol GamePresenterProtocol {
    
    func setBet(bet: Double)
    func setIsAnimation(_ isAnimation: Bool)
    func isDisableStartButton(_ isDisable: Bool)
    func didTapOpenBettingFieldView(with bet: Double)
    func didTapStartButton()
    func getWinningSector()
    func getUserData()
    func removeLoader() 
}
