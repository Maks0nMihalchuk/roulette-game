//
//  GamePresenter.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Foundation

class GamePresenter: GamePresenterProtocol {
    
    private let loader = Loader(color: .systemBlue)
    private let model: GameModelProtocol
    private let transition: GameTransition
    
    private var isAnimation: Bool = false {
        didSet {
            view?.isDisableActions(isAnimation)
        }
    }
    
    private var bet: Double = .zero {
        didSet {
            if bet != .zero {
                
            }
        }
    }
    
    weak var view: GameViewProtocol?
    
    init(_ view: GameViewProtocol, model: GameModelProtocol, transition: GameTransition) {
        self.view = view
        self.model = model
        self.transition = transition
    }
    
    func isDisableStartButton(_ isDisable: Bool) {
        view?.isDisableStartButton(isDisable)
    }
    
    func getUserData() {
        loader.show()
        model.getUserData { [weak self] result in
            guard let self = self else { return }
            
            self.loader.hide()
            
            switch result {
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            case .success(let data):
                self.view?.getUserName(data.username)
                self.view?.getUserCurrentBalance(data.coinBalance)
            }
        }
    }
    
    func setBet(bet: Double) {
        self.bet = bet
    }
    
    func setIsAnimation(_ isAnimation: Bool) {
        self.isAnimation = isAnimation
    }
    
    func getWinningSector() {
//        bet = .zero
        let sector = model.getWinningSector()
        view?.setTextInSectorLabel("\(sector.number) " + sector.color.rawValue)
    }
    
    func didTapStartButton() {
        setIsAnimation(true)
        view?.startAnimation(with: model.getRandomAngle())
        view?.setTextInSectorLabel(model.getDefaultSectorLabelText())
    }
    
    func didTapOpenBettingFieldView(with bet: Double) {
        if bet != .zero {
            transition.openBettingField(bet)
        } else {
            view?.showError(model.getZeroRateErrorMessage())
        }
    }
    
    func removeLoader() {
        Loader.remove()
    }
}
