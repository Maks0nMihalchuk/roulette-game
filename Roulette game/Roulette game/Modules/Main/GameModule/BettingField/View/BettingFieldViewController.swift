//
//  BettingFieldViewController.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import UIKit

class BettingFieldViewController: UIViewController {
    
    private enum Constants {
        static let roundedButton: CGFloat = 15
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var placeBetButton: UIButton!
    
    var presenter: BettingFieldPresenterProtocol?
    var dataSource: BettingFieldDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlaceBetButton()
        setupCollectionView()
    }
    
    @IBAction private func didTapPlaceBetButton(_ sender: UIButton) {
        print("didTapPlaceBetButton")
    }
    
    
}

// MARK: - BettingFieldViewProtocol
extension BettingFieldViewController: BettingFieldViewProtocol {
    
}

// MARK: - setup UI
private extension BettingFieldViewController {
    
    func setupPlaceBetButton() {
        placeBetButton.rounded(Constants.roundedButton)
    }
    
    func setupCollectionView() {
        guard let dataSource = dataSource else { return }
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.collectionViewLayout = dataSource.setupCollectionViewLayout()
        collectionView.regiserCellByClass(cellClass: NumberCollectionViewCell.self)
        collectionView.regiserCellByClass(
            cellClass: OuterCollectionViewCellWithText.self
        )
        collectionView.regiserCellByClass(
            cellClass: OuterCollectionViewCellWithImage.self
        )
    }
}
