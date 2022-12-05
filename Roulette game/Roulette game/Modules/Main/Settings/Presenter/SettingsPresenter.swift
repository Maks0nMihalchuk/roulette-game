//
//  SettingsPresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

class SettingPresenter: SettingPresenterProtocol {
    
    private let model: SettingModelProtocol
    
    weak var view: SettingViewProtocol?
    
    init(_ view: SettingViewProtocol, model: SettingModelProtocol) {
        self.view = view
        self.model = model
    }
}
