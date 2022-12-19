//
//  ZeroCollectionViewCell.swift
//  Roulette game
//
//  Created by Максим Михальчук on 09.12.2022.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell, Reusable {
    
    private enum Constants {
        static let greenColor = "greenColor"
    }
    
    @IBOutlet private weak var numberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setupCell(with bettingFieldElement: BettingField) {
        numberLabel.text = bettingFieldElement.text
        
        switch bettingFieldElement.color {
        case .green:
            let color = UIColor(named: Constants.greenColor) ?? .systemGreen
            self.backgroundColor = color
        case .black:
            self.backgroundColor = .black
        case .red:
            self.backgroundColor = .systemRed
        }
    }
}

