//
//  BettingFieldViewProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import Foundation

protocol BettingFieldViewProtocol: AnyObject {
    
    func setupBetAlert(with dataModel: BetAlertViewDataModel)
    func isErrorInEnteredBet(_ isError: Bool)
    func showBetAlertView()
    func hideBetAlertView()
}
