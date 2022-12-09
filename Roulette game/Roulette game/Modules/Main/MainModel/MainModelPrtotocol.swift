//
//  MainModelPrtotocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 06.12.2022.
//

import Foundation

protocol MainModelProtocol {
    func getUserData(completion: @escaping BlockWith<Result<User, Error>>)
}

class MainModel: MainModelProtocol {
    
    private var authService: FirebaseAuthManagerProtocol
    
    var userModel: User?
    var firebaseManager: FirebaseMainManagerProtocol
    
    init(firebaseManager: FirebaseMainManagerProtocol,
         authService: FirebaseAuthManagerProtocol) {
        self.firebaseManager = firebaseManager
        self.authService = authService
    }
    
    func getUserData(completion: @escaping BlockWith<Result<User, Error>>) {
        guard let uid = getIdCurrentUser() else { return }

        firebaseManager.getUserData(for: uid) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.userModel = user
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func getIdCurrentUser() -> String? {
        return authService.getIdCurrentUser()
    }
    
}
