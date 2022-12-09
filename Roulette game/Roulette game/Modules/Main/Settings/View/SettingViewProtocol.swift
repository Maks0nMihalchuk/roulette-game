//
//  SettingViewProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

protocol SettingViewProtocol: AnyObject {
    
    func showError(_ message: String)
    func getCurrentBalance(_ balance: String)
    func getUsername(_ name: String)
}
