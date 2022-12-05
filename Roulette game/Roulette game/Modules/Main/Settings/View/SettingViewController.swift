//
//  SettingViewController.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import UIKit

class SettingViewController: UIViewController {
    
    var presenter: SettingPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - SettingViewProtocol

extension SettingViewController: SettingViewProtocol {
    
}
