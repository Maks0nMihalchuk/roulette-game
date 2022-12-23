//
//  BettingFieldPresenterProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import Foundation

protocol BettingFieldPresenterProtocol {
    
    func setupBetAlert()
    func isValidEnteredBet(_ textBet: String)
    func didTapCell(in section: Int, with number: Int)
}
