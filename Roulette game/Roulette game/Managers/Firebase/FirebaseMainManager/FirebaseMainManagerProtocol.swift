//
//  FirebaseMainManagerProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

protocol FirebaseMainManagerProtocol {
 
    func getUserData(for id: String, completion: @escaping BlockWith<Result<User, Error>>)
}
