//
//  BettingFieldDataSource.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import UIKit

enum BettingFieldElements: CaseIterable {
    case zero
//    case numberElement
//    case averageCellSize // color elements, even or odd element, low elements, height elements
//    case largeCellSize // cells describing a group of elements (numbers from 1 to 12) etc.
}

enum BettingFieldCollectionViewElements {
    case zero
    case numberElement   // from 1 to 36
    case columnBetElement // full line bet (3 lines)
    case blackElement
    case redElement
    case evenElement    // четные числа
    case oddElement     // нечетные числа
    case lowElemnts     // elements from 1 to 18
    case hightElements  // elements from 19 to 36
    case firstDozen     // (numbers from 1 to 12)
    case secondDozen    // (numbers from 13 to 24)
    case thirdDozen     // (numbers from 25 to 36)
}

class BettingFieldDataSource: NSObject, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return BettingFieldElements.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionViewSections = BettingFieldElements.allCases[section]
//
        switch collectionViewSections {
        case .zero: return 1
        case .numberElement: return 15
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCellBy(cellClass: NumberCollectionViewCell.self, indexPath: indexPath)
        cell.setupCell(with: "\(indexPath.item)",
                       color: UIColor(named: "greenColor") ?? .blue)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension BettingFieldDataSource: UICollectionViewDelegate {
    
}

// MARK: - setup Collection View Layout
extension BettingFieldDataSource {
    
    func setupCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment)  -> NSCollectionLayoutSection? in
            let collectionViewSections = BettingFieldElements.allCases[sectionIndex]
//
            switch collectionViewSections {
            case .zero: return self.setupZeroItemSection()
//            case .numberElement: return self.numbresItemSection()
            }
        }
        return layout
    }
    
    func setupZeroItemSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.51),
            heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
//    func numbresItemSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(0.3),
//            heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0), // 0.51
//            heightDimension: .absolute(50)) // 0.25
//        let group = NSCollectionLayoutGroup.horizontal(
//            layoutSize: groupSize,
//            repeatingSubitem: item,
//            count: 3)
//        group.interItemSpacing = .fixed(4)
//        let rootGroupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(0.51), // 0.51
//            heightDimension: .absolute(215)) // 0.25
//        let rootGroup = NSCollectionLayoutGroup.vertical(
//            layoutSize: rootGroupSize,
//            repeatingSubitem: group,
//            count: 4)
//        rootGroup.contentInsets.leading = 20
//        rootGroup.interItemSpacing = .fixed(2)
//
//        let test = test()
//        let mainGroupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .absolute(220))
//        let mainGroop = NSCollectionLayoutGroup.horizontal(layoutSize: mainGroupSize, subitems: [rootGroup, test])
//
//        let section = NSCollectionLayoutSection(group: mainGroop)
//        return section
//    }
    
//    func test() -> NSCollectionLayoutGroup {
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(0.3),
//            heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let secondItemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .fractionalHeight(0.5))
//        let secondItem = NSCollectionLayoutItem(layoutSize: secondItemSize)
//
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(0.19),
//            heightDimension: .fractionalHeight(1.0))
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: secondItem, count: 2)
//
//        let rootGroupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(4.9),
//            heightDimension: .fractionalHeight(1.0))
//        let rootGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rootGroupSize, subitems: [item, group])
//
//        return rootGroup
//    }
}
