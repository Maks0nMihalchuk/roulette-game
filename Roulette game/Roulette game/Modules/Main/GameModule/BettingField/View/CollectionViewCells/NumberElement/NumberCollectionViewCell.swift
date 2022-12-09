//
//  ZeroCollectionViewCell.swift
//  Roulette game
//
//  Created by Максим Михальчук on 09.12.2022.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell, Reusable {
    
    @IBOutlet private weak var numberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setupCell(with number: String, color: UIColor) {
        self.numberLabel.text = number
        self.backgroundColor = color
    }
}

