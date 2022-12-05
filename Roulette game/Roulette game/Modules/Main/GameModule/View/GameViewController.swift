//
//  GameViewController.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    var presenter: GamePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - GameViewProtocol
extension GameViewController: GameViewProtocol {
    
}
