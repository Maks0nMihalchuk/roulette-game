//
//  Reusable.swift
//  Roulette game
//
//  Created by Максим Михальчук on 09.12.2022.
//

import Foundation

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
