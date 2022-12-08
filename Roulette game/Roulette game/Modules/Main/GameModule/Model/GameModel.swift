//
//  GameModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

enum Color: String {
    case red = "RED"
    case black = "BLACK"
    case green = "ZERO"
}

struct Sector: Equatable {
    let number: Int
    let color: Color
}

class GameModel: GameModelProtocol {
    
    private enum Constants {
        static let minAngleInDegrees: Double = 1
        static let fullTurnInDegrees: Double = 360
        static let halfTurnInDegrees: Double = 180
        static let defaultBallRotation = 0.455
        static let radianOfSector: Double = 0.16980
        static let defaultSectorLabelText = "..."
    }
    
    private let authService: FirebaseAuthManagerProtocol
    private let firebaseManager: FirebaseMainManagerProtocol
    private var userModel: User?
    private var sectors: [Sector] = []
    
    var randomAngle: Double = .zero
    
    init(firebaseManager: FirebaseMainManagerProtocol,
         authService: FirebaseAuthManagerProtocol) {
        self.firebaseManager = firebaseManager
        self.authService = authService
        setupSectors()
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
    
    func getWinningSector() -> Sector {
        let sector = (randomAngle + Constants.defaultBallRotation) / Constants.radianOfSector
        var winningSector = Int(round(sector))
        
        if winningSector >= sectors.count {
            winningSector -= sectors.count
        }
        
        print(sectors[winningSector])
        return sectors[winningSector]
    }
    
    func getRandomAngle() -> Double {
        let angle = Double.random(in: Constants.minAngleInDegrees...Constants.fullTurnInDegrees)
        randomAngle = (angle * .pi) / Constants.halfTurnInDegrees - Constants.defaultBallRotation
        return randomAngle
    }
    
    func getDefaultSectorLabelText() -> String {
        return Constants.defaultSectorLabelText
    }
}

// MARK: - get current user ID
private extension GameModel {
    
    func getIdCurrentUser() -> String? {
        return authService.getIdCurrentUser()
    }
}

// MARK: - setup sectors array
private extension GameModel {
    
    func setupSectors() {
        sectors = [Sector(number: 0, color: .green),
                   Sector(number: 32, color: .red), Sector(number: 15, color: .black),
                   Sector(number: 19, color: .red), Sector(number: 4, color: .black),
                   Sector(number: 21, color: .red), Sector(number: 2, color: .black),
                   Sector(number: 25, color: .red), Sector(number: 17, color: .black),
                   Sector(number: 34, color: .red), Sector(number: 6, color: .black),
                   Sector(number: 27, color: .red), Sector(number: 13, color: .black),
                   Sector(number: 36, color: .red), Sector(number: 11, color: .black),
                   Sector(number: 30, color: .red), Sector(number: 8, color: .black),
                   Sector(number: 23, color: .red), Sector(number: 10, color: .black),
                   Sector(number: 5, color: .red), Sector(number: 24, color: .black),
                   Sector(number: 16, color: .red), Sector(number: 33, color: .black),
                   Sector(number: 1, color: .red), Sector(number: 20, color: .black),
                   Sector(number: 14, color: .red), Sector(number: 31, color: .black),
                   Sector(number: 9, color: .red), Sector(number: 22, color: .black),
                   Sector(number: 18, color: .red), Sector(number: 29, color: .black),
                   Sector(number: 7, color: .red), Sector(number: 28, color: .black),
                   Sector(number: 12, color: .red), Sector(number: 35, color: .black),
                   Sector(number: 3, color: .red), Sector(number: 26, color: .black)
        ]
    }
}
