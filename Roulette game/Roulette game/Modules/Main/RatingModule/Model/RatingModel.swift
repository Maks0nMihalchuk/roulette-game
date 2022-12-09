//
//  RatingModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

class RatingModel: RatingModelProtocol {
    
    private let firebaseManager: FirebaseMainManagerProtocol
    
    init(firebaseManager: FirebaseMainManagerProtocol) {
        self.firebaseManager = firebaseManager
    }
}
