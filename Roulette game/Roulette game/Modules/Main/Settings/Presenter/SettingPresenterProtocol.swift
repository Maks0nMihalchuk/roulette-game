//
//  SettingPresenterProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

protocol SettingPresenterProtocol {
    func getUserData()
    func didTapSignOut()
    func didTapDeleteAccount()
    func didTapShareApp()
    func didTapRateApp()
}
