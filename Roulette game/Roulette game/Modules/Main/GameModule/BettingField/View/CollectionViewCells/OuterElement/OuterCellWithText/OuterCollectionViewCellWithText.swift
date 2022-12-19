//
//  OuterCollectionViewCell.swift
//  Roulette game
//
//  Created by Максим Михальчук on 19.12.2022.
//

import UIKit

class OuterCollectionViewCellWithText: UICollectionViewCell, Reusable {
    
    private enum Constants {
        static let greenColor = "greenColor"
        static let two: CGFloat = 2
    }
    
    @IBOutlet private weak var outerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        outerLabel.isHidden = false
    }
    
    func setupCell(with bettingFieldElement: BettingField) {
        outerLabel.transform = CGAffineTransform(rotationAngle: .pi / Constants.two)
        outerLabel.text = bettingFieldElement.text
        let color = UIColor(named: Constants.greenColor) ?? .systemGreen
        self.backgroundColor = color
    }
}
