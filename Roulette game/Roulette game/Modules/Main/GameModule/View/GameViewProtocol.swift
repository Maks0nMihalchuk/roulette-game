//
//  GameViewProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

protocol GameViewProtocol: AnyObject {
    
    func showError(_ message: String)
    func isDisableActions(_ isDisable: Bool)
    func isDisableStartButton(_ isDisable: Bool)
    func startAnimation(with angle: Double)
    func setTextInSectorLabel(_ text: String)
    func getUserName(_ name: String)
    func getUserCurrentBalance(_ balance: Int)
}
