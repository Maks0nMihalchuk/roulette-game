//
//  SignUpPresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 04.12.2022.
//

import Foundation
import UIKit.UIColor

class SignUpPresenter: SignUpPresenterProtocol {
    
    private let loader = Loader(color: .systemBlue)
    private let model: SignUpModelProtocol
    private var transitions: SignUpTransitions
    
    weak var view: SignUpViewProtocol?
    
    init(_ view: SignUpViewProtocol, model: SignUpModelProtocol, transitions: SignUpTransitions) {
        self.view = view
        self.model = model
        self.transitions = transitions
    }
}
