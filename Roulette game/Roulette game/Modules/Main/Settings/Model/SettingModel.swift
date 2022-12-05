//
//  SettingModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

class SettingModel: SettingModelProtocol {
    
    private let firebaseManager: FirebaseMainManagerProtocol
    
    init(firebaseManager: FirebaseMainManagerProtocol) {
        self.firebaseManager = firebaseManager
    }
    
}
