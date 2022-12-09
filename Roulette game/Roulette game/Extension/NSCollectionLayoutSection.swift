//
//  NSCollectionLayoutSection.swift
//  Roulette game
//
//  Created by Максим Михальчук on 08.12.2022.
//

import UIKit

extension NSCollectionLayoutSection {

    // left right swipe list
    static func verticalLayout(width: CGFloat = UIScreen.main.bounds.width,
                               height: CGFloat,
                               header: Bool = false,
                               footer: Bool = false,
                               headerHeighDimension: NSCollectionLayoutDimension = .estimated(44),
                               footerHeighDimension: NSCollectionLayoutDimension = .estimated(44),
                               reuseIdentifier: String = "",
                               footerReuseIdentifier: String = ""
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        if header {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: headerHeighDimension)
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: reuseIdentifier, alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
        }
        if footer {
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: footerHeighDimension)
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: footerReuseIdentifier, alignment: .bottom)
                section.boundarySupplementaryItems.append(sectionFooter)
        }
        return section
    }

    // up down swipe list
    static func horizontalLayout(height: CGFloat? = nil,
                                 width: CGFloat? = UIScreen.main.bounds.width,
                                 header: Bool = false,
                                 headerHeighDimension: NSCollectionLayoutDimension = .estimated(44),
                                 columnCount: Int = 1,
                                 estimated: CGFloat? = nil,
                                 reuseIdentifier: String = ""
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: height != nil ? .absolute(height!) : .estimated(estimated ?? 200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: height != nil ? .absolute(height!) : .estimated(estimated ?? 200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: columnCount)
        let section = NSCollectionLayoutSection(group: group)
        if header {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: headerHeighDimension)
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: reuseIdentifier, alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
        }
        return section
    }
}
