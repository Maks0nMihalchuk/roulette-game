//
//  GamePresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

class GamePresenter: GamePresenterProtocol {
    
    private let model: GameModelProtocol
    
    weak var view: GameViewProtocol?
    
    init(_ view: GameViewProtocol, model: GameModelProtocol) {
        self.view = view
        self.model = model
    }
    
}
