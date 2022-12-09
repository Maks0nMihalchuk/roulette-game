//
//  SettingModelProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

protocol SettingModelProtocol {
    func getUserData(completion: @escaping BlockWith<Result<User, Error>>)
    
    func getShareAppURL() -> [URL]?
    
    func signOut(completion: @escaping ((Resulter<Error>) -> Void))
    func deleteAccount(completion: @escaping ((Resulter<AuthErrors>) -> Void))
}
