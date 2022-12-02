//
//  BuilderProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 01.12.2022.
//

import UIKit

protocol BuilderProtocol {
    func getViewController(_ controllerID: String, storyboardName name: Storyboard) -> UIViewController
}

extension BuilderProtocol {

    private func getStoryboard(name: Storyboard) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue, bundle: nil)
    }

    func getViewController(_ controllerID: String, storyboardName name: Storyboard) -> UIViewController {
        let controller = getStoryboard(name: name)
            .instantiateViewController(withIdentifier: controllerID)

        return controller
    }
}
