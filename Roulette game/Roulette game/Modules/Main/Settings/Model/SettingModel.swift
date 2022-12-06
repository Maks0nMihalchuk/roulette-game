//
//  SettingModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

class SettingModel: SettingModelProtocol {
    
    private enum Constants {
        static let defaultBalance = 0
        static let shareAppString = "https://www.apple.com/ua/"
    }
    
    
    private let firebaseManager: FirebaseMainManagerProtocol
    private let authService: FirebaseAuthManagerProtocol
    
    init(firebaseManager: FirebaseMainManagerProtocol,
         authService: FirebaseAuthManagerProtocol) {
        self.firebaseManager = firebaseManager
        self.authService = authService
    }
    
    func getShareAppURL() -> [URL]? {
        guard let url = URL(string: Constants.shareAppString) else { return nil}
        
        return [url]
    }
    
    func getUserData(completion: @escaping BlockWith<Result<User, Error>>) {
        guard let uid = getIdCurrentUser() else { return }
        
        firebaseManager.getUserData(for: uid, completion: completion)
    }
    
    func signOut(completion: @escaping ((Resulter<Error>) -> Void)) {
        authService.signOut(completion: completion)
    }
    
    func deleteAccount(completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
        authService.deleteAccount { result in
            print(result)
        }
    }
    
    private func getIdCurrentUser() -> String? {
        return authService.getIdCurrentUser()
    }
}
