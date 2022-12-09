//
//  RatingViewController.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import UIKit

class RatingViewController: UIViewController {
    
    var presenter: RatingPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - RatingViewProtocol
extension RatingViewController: RatingViewProtocol {
    
}
