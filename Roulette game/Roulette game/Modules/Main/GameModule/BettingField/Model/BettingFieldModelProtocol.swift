//
//  BettingFieldModelProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import Foundation

protocol BettingFieldModelProtocol {
    
    func getBetAlertViewDataModel() -> BetAlertViewDataModel
    func isValidEnteredBet(_ textBet: String) -> Bool
}
