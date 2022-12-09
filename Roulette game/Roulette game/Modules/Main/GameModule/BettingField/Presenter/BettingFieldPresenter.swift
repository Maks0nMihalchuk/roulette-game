//
//  BettingFieldPresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import Foundation

class BettingFieldPresenter: BettingFieldPresenterProtocol {
    
    private let model: BettingFieldModelProtocol
    private let transition: BettingFieldTransition
    
    weak var view: BettingFieldViewProtocol?
    
    init(_ view: BettingFieldViewProtocol, model: BettingFieldModelProtocol, transition: BettingFieldTransition) {
        self.view = view
        self.model = model
        self.transition = transition
    }
}
