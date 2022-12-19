//
//  BettingFieldDataSource.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import UIKit

enum BettingFieldElements: CaseIterable {
    case zero
    case mainPlayingField
    case collumnBetElements
}

class BettingFieldDataSource: NSObject, UICollectionViewDataSource {
    
    private enum Constants {
        static let fullInterval: CGFloat = 5
        static let halfInterval: CGFloat = 2.5
        
        static let numberOfElementsInOtherSections = 15
        static let horizontalNumberOfNumbers = 3
        static let verticalNumberOfNumbers = 4
        static let numberOfOuterVerticalCells = 2
        
        static let numberOfElementsInMainField = 45
        static let numberOfItemsInAdditionalField = 3
        static let oneInt = 1
        static let one: CGFloat = 1
        static let numberCellSize: CGFloat = 70
        static let widthOfAllNumericElements: CGFloat = 220
        static let offsetForOuterCells: CGFloat = 235
        static let sectionHeight: CGFloat = 295
        static let dozenGroupWidth: CGFloat = 0.5
        static let outerItemHeight: CGFloat = 0.5
        static let outerGroupWidth: CGFloat = 0.5
    }
    
    private var bettingField: [BettingField]
    
    init(bettingField: [BettingField]) {
        self.bettingField = bettingField
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return BettingFieldElements.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionViewSections = BettingFieldElements.allCases[section]

        switch collectionViewSections {
        case .zero: return Constants.oneInt
        case .mainPlayingField: return Constants.numberOfElementsInMainField
        case .collumnBetElements: return Constants.numberOfItemsInAdditionalField
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let numberCell = collectionView.dequeueCellBy(
            cellClass: NumberCollectionViewCell.self,
            indexPath: indexPath
        )
        let outerCellWithText = collectionView.dequeueCellBy(
            cellClass: OuterCollectionViewCellWithText.self,
            indexPath: indexPath
        )
        
        let outerCellWithImage = collectionView.dequeueCellBy(
            cellClass: OuterCollectionViewCellWithImage.self,
            indexPath: indexPath
        )
        
        switch BettingFieldElements.allCases[indexPath.section] {
        case .zero:
            numberCell.setupCell(with: bettingField.reversed()[indexPath.item])
            return numberCell
        case .mainPlayingField:
            switch indexPath.item {
            case 12...14, 27, 42...44:
                outerCellWithText.setupCell(with: bettingField[indexPath.item])
                return outerCellWithText
            case 28...29:
                outerCellWithImage.setupCell(with: bettingField[indexPath.item])
                return outerCellWithImage
            default:
                numberCell.setupCell(with: bettingField[indexPath.item])
                return numberCell
            }
        case .collumnBetElements:
            numberCell.setupCell(with: bettingField.reversed()[Constants.oneInt])
            return numberCell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension BettingFieldDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - setup Collection View Layout
extension BettingFieldDataSource {
    
    func setupCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment)  -> NSCollectionLayoutSection? in
            let collectionViewSections = BettingFieldElements.allCases[sectionIndex]

            switch collectionViewSections {

            case .zero: return self.setupZeroItemSection()
            case .mainPlayingField: return self.setupOfElementsInOtherSections()
            case .collumnBetElements: return self.setupCollumnBetSection()
            }
        }
        return layout
    }
    
    private func setupZeroItemSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(Constants.widthOfAllNumericElements),
            heightDimension: .fractionalHeight(Constants.one)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.one),
            heightDimension: .absolute(Constants.numberCellSize)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.fullInterval, leading: Constants.fullInterval,
            bottom: .zero, trailing: Constants.fullInterval
        )
        return section
    }
    
    private func setupOfElementsInOtherSections() -> NSCollectionLayoutSection {
        let groupOfNumericElements = getGroupOfNumericElements()
        let dozenElement = getDozenElement()
        let groupOfExternalElements = getGroupOfOuterElements()
        
        let outsideRootGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(UIScreen.main.bounds.width - Constants.offsetForOuterCells),
            heightDimension: .fractionalHeight(Constants.one)
        )
        let outsideRootGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: outsideRootGroupSize,
            subitems: [dozenElement, groupOfExternalElements]
        )
        
        let rootGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.one),
            heightDimension: .absolute(Constants.sectionHeight)
        )
        let rootGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: rootGroupSize,
            subitems: [groupOfNumericElements, outsideRootGroup]
        )
        rootGroup.interItemSpacing = .fixed(Constants.fullInterval)

        let section = NSCollectionLayoutSection(group: rootGroup)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.fullInterval,
            leading: Constants.fullInterval,
            bottom: .zero,
            trailing: Constants.fullInterval
        )
        section.interGroupSpacing = Constants.fullInterval
        return section
    }
    
    private func getGroupOfNumericElements() -> NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(Constants.numberCellSize),
            heightDimension: .absolute(Constants.numberCellSize)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let verticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(Constants.numberCellSize),
            heightDimension: .fractionalHeight(Constants.one)
        )
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: verticalGroupSize,
            repeatingSubitem: item,
            count: Constants.verticalNumberOfNumbers
        )
        verticalGroup.interItemSpacing = .fixed(Constants.fullInterval)
        let horizontalGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(Constants.widthOfAllNumericElements),
            heightDimension: .fractionalHeight(Constants.one)
        )
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: horizontalGroupSize,
            repeatingSubitem: verticalGroup,
            count: Constants.horizontalNumberOfNumbers
        )
        horizontalGroup.interItemSpacing = .fixed(Constants.fullInterval)
        return horizontalGroup
    }
    
    private func getDozenElement() -> NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.one),
            heightDimension: .fractionalHeight(Constants.one)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.dozenGroupWidth),
            heightDimension: .fractionalHeight(Constants.one)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.contentInsets.trailing = Constants.fullInterval
        return group
    }
    
    private func getGroupOfOuterElements() -> NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.one),
            heightDimension: .fractionalHeight(Constants.outerItemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.outerGroupWidth),
            heightDimension: .fractionalHeight(Constants.one)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: Constants.numberOfOuterVerticalCells
        )
        group.interItemSpacing = .fixed(Constants.fullInterval)
        return group
    }
    
    
    private func setupCollumnBetSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(Constants.numberCellSize),
            heightDimension: .fractionalHeight(Constants.one)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(Constants.widthOfAllNumericElements),
            heightDimension: .absolute(Constants.numberCellSize)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: Constants.horizontalNumberOfNumbers
        )
        group.interItemSpacing = .fixed(Constants.fullInterval)
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.fullInterval,
            leading: Constants.fullInterval,
            bottom: Constants.fullInterval,
            trailing: Constants.fullInterval
        )
        return section
    }
}
