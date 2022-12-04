//
//  SignUpViewController.swift
//  Roulette game
//
//  Created by Максим Михальчук on 04.12.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var presenter: SignUpPresenterProtocol?

    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

}

// MARK: - SignUpViewProtocol
extension SignUpViewController: SignUpViewProtocol {
    
}
