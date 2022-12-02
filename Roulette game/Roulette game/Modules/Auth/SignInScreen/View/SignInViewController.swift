//
//  SignInViewController.swift
//  Roulette game
//
//  Created by Максим Михальчук on 01.12.2022.
//

import UIKit

class SignInViewController: UIViewController {
    
    var presenter: SignInPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

// MARK: - SignInViewProtocol
extension SignInViewController: SignInViewProtocol {
    
}
