//
//  RatingPresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

class RatingPresenter: RatingPresenterProtocol {
    
    private let model: RatingModelProtocol
    
    weak var view: RatingViewProtocol?
    
    init(_ view: RatingViewProtocol, model: RatingModelProtocol) {
        self.view = view
        self.model = model
    }
}
