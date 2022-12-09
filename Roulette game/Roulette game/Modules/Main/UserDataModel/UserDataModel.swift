//
//  UserDataModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 06.12.2022.
//

import Foundation

struct User: Codable {
    var coinBalance: Int
    let username: String
    var winRate: String
}
