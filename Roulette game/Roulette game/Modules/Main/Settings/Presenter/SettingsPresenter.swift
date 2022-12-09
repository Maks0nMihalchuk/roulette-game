//
//  SettingsPresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

class SettingPresenter: SettingPresenterProtocol {
    
    private let model: SettingModelProtocol
    private let transitions: SettingsTransitions
    weak var view: SettingViewProtocol?
    
    init(_ view: SettingViewProtocol, model: SettingModelProtocol, transitions: SettingsTransitions) {
        self.view = view
        self.model = model
        self.transitions = transitions
    }
    
    func getUserData() {
        model.getUserData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.view?.getCurrentBalance(String(data.coinBalance))
                self.view?.getUsername(data.username)
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func didTapShareApp() {
        guard let data = model.getShareAppURL() else { return }
        
        transitions.shareApp(data)
    }
    
    func didTapRateApp() {
        transitions.rateApp()
    }
    
    func didTapSignOut() {
        model.signOut { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success: break
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func didTapDeleteAccount() {
        model.deleteAccount() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.view?.showError(error.description)
            case .success: break
            }
        }
    }
}
