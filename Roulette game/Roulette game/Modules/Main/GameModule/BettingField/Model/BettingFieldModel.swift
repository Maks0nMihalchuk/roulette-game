//
//  BettingFieldModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import Foundation

class BettingFieldModel: BettingFieldModelProtocol {
 
    var bet: Double
    
    init(bet: Double) {
        self.bet = bet
    }
}
