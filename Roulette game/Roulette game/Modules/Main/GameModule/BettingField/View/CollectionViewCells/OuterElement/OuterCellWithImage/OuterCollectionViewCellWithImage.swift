//
//  OuterCollectionViewCellWithImage.swift
//  Roulette game
//
//  Created by Максим Михальчук on 19.12.2022.
//

import UIKit

class OuterCollectionViewCellWithImage: UICollectionViewCell, Reusable {

    @IBOutlet private weak var outerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(with bettingFieldElement: BettingField) {
        outerImageView.image = bettingFieldElement.image
        
        switch bettingFieldElement.color {
        case .black: outerImageView.tintColor = .black
        case .red: outerImageView.tintColor = .systemRed
        default: break
        }
    }

}
