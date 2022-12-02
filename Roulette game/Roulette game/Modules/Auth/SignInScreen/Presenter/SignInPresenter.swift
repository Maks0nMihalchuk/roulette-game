//
//  SignInPresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation

class SignInPresenter: SignInPresenterProtocol {
    
//    private let loader
    private let model: SignInModelProtocol
    private var transitions: SignInTransitions
    
    weak var view: SignInViewProtocol?
    
    init(_ view: SignInViewProtocol, model: SignInModelProtocol, transitions: SignInTransitions) {
        self.view = view
        self.model = model
        self.transitions = transitions
    }
}
