//
//  BuilderProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 01.12.2022.
//

import UIKit

protocol BuilderProtocol {
    func getViewController(controllerID id: String, storyboardName name: Storyboard) -> UIViewController
}

extension BuilderProtocol {

    private func getStoryboard(name: Storyboard) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue, bundle: nil)
    }

    func getViewController(controllerID id: String, storyboardName name: Storyboard) -> UIViewController {
        let controller = getStoryboard(name: name)
            .instantiateViewController(withIdentifier: id)

        return controller
    }
}
