//
//  BettingFieldModel.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import Foundation
import UIKit.UIImage

struct BettingField {
    let text: String
    let color: Color
    let image: UIImage?
    
    init(text: String = "", color: Color, image: UIImage? = nil) {
        self.text = text
        self.color = color
        self.image = image
    }
}

struct BetAlertViewDataModel {
    var headerText: String
    var errorText: String
    var textFieldPlaceholder: String
    var betAction: BlockWith<String>?
    var cancelAction: VoidCallBlock?
}

class BettingFieldModel: BettingFieldModelProtocol {
    
    private enum Constants {
        static let betAlertHeaderText = "Enter the amount you want to bet on the selected sector, but not more than "
        static let betAlertErrorText = "The entered bet is greater than the amount selected earlier!"
        static let BetAlertTextFieldPlaceholder = "Enter your rate"
    }
    
    private var bet: Double
    private var bettingField: [BettingField] = []
    private let validationService: ValidationManagerProtocol
    
    init(bet: Double, validationService: ValidationManagerProtocol) {
        self.validationService = validationService
        self.bet = bet
        setupBettingField()
    }
    
    func getBettingField() -> [BettingField] {
       return bettingField
    }
    
    func getBetAlertViewDataModel() -> BetAlertViewDataModel {
        return BetAlertViewDataModel(
            headerText: Constants.betAlertHeaderText + "\(bet)",
            errorText: Constants.betAlertErrorText,
            textFieldPlaceholder: Constants.BetAlertTextFieldPlaceholder
        )
    }
    
    func isValidEnteredBet(_ textBet: String) -> Bool {
        return validationService.isValidBet(textBet, maxBet: bet)
    }
    
    func setupBettingField() {
        let rhombusImage = UIImage(systemName: "rhombus.fill")
        
        bettingField = [
            BettingField(text: "1", color: .red),
            BettingField(text: "4", color: .black),
            BettingField(text: "7", color: .red),
            BettingField(text: "10", color: .black),
            
            BettingField(text: "2", color: .black),
            BettingField(text: "5", color: .red),
            BettingField(text: "8", color: .black),
            BettingField(text: "11", color: .black),
            
            BettingField(text: "3", color: .red),
            BettingField(text: "6", color: .black),
            BettingField(text: "9", color: .red),
            BettingField(text: "12", color: .red),
            
            BettingField(text: "1st Dozen", color: .green),
            BettingField(text: "1 to 18", color: .green),
            BettingField(text: "Even", color: .green),
            
            BettingField(text: "13", color: .black),
            BettingField(text: "16", color: .red),
            BettingField(text: "19", color: .black),
            BettingField(text: "22", color: .black),
            
            BettingField(text: "14", color: .red),
            BettingField(text: "17", color: .black),
            BettingField(text: "20", color: .black),
            BettingField(text: "23", color: .red),
            
            BettingField(text: "15", color: .black),
            BettingField(text: "18", color: .red),
            BettingField(text: "21", color: .red),
            BettingField(text: "24", color: .black),
            
            BettingField(text: "2nd Dozen", color: .green),
            BettingField(color: .red, image: rhombusImage),
            BettingField(color: .black, image: rhombusImage),
            
            BettingField(text: "25", color: .red),
            BettingField(text: "28", color: .red),
            BettingField(text: "31", color: .black),
            BettingField(text: "34", color: .red),
            
            BettingField(text: "26", color: .black),
            BettingField(text: "29", color: .black),
            BettingField(text: "32", color: .red),
            BettingField(text: "35", color: .black),
            
            BettingField(text: "27", color: .red),
            BettingField(text: "30", color: .red),
            BettingField(text: "33", color: .black),
            BettingField(text: "36", color: .red),

            BettingField(text: "3rd Dozen", color: .green),
            BettingField(text: "Odd", color: .green),
            BettingField(text: "19 to 36", color: .green),
            
            BettingField(text: "2 to 1", color: .green),
            BettingField(text: "0", color: .green),
        ]
    }
}
