//
//  UICollectionView+Extension.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import UIKit

extension UICollectionView {
    
    public func regiserCellByClass<T: UICollectionViewCell>(cellClass: T.Type) {
        let className = String(describing: cellClass)
        let bundle = Bundle(identifier: "com.roulette-game.Roulette-game")
        register(UINib(nibName: className, bundle: bundle), forCellWithReuseIdentifier: className)
    }
    
    public func regiserHeaderByClass<T: UICollectionReusableView>(cellClass: T.Type) {
        let className = String(describing: cellClass)
        let bundle = Bundle(identifier: "com.roulette-game.Roulette-game")
        register(UINib(nibName: className, bundle: bundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }
    
    public func regiserFooterByClass<T: UICollectionReusableView>(cellClass: T.Type) {
        let className = String(describing: cellClass)
        let bundle = Bundle(identifier: "com.roulette-game.Roulette-game")
        register(UINib(nibName: className, bundle: bundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
    }

    public func dequeueCellBy<T: UICollectionViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T else {
            fatalError("dequeueCellBy method has not worked correctly")
        }
        return cell
    }
}
