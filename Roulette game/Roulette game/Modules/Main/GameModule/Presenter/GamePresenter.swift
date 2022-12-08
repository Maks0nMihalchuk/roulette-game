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
    
    private var isAnimation: Bool = false {
        didSet {
            view?.isDisableActions(isAnimation)
        }
    }
    
    weak var view: GameViewProtocol?
    
    init(_ view: GameViewProtocol, model: GameModelProtocol) {
        self.view = view
        self.model = model
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
    
    func setIsAnimation(_ isAnimation: Bool) {
        self.isAnimation = isAnimation
    }
    
    func getWinningSector() {
        let sector = model.getWinningSector()
        view?.setTextInSectorLabel("\(sector.number) " + sector.color.rawValue)
    }
    
    func didTapStartButton() {
        setIsAnimation(true)
        view?.startAnimation(with: model.getRandomAngle())
        view?.setTextInSectorLabel(model.getDefaultSectorLabelText())
    }
    
    func removeLoader() {
        Loader.remove()
    }
}
