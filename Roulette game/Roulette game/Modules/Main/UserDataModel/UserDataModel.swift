//
//  UserDataModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 06.12.2022.
//

import Foundation

struct User: Codable {
    let coinBalance: Int
    let username: String
    let winRate: String
}
