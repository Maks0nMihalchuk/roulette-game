//
//  SettingViewController.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import UIKit

class SettingViewController: UIViewController {
    
    private enum Constants {
        static let roundedButton: CGFloat = 15
        static let roundedHeaderView: CGFloat = 20
        static let viewShadowOffset: CGSize = CGSize(width: 1, height: 4)
        static let viewShadowRadius: CGFloat = 5
        static let viewShadowOpacity: Float = 0.6
        static let buttonBorderWidth: CGFloat = 2
        static let buttonShadowOffset: CGSize = CGSize(width: 1, height: 4)
        static let buttonShadowRadius: CGFloat = 2
        static let buttonShadowOpacity: Float = 0.4
    }
    
    @IBOutlet private weak var backgroundHeaderView: UIView!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userBalanceLabel: UILabel!
    @IBOutlet private weak var rateAppButton: UIButton!
    @IBOutlet private weak var shareAppButton: UIButton!
    @IBOutlet private weak var deleteAccountButton: UIButton!
    @IBOutlet private weak var logOutButton: UIButton!
    
    var presenter: SettingPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupHeaderView()
        presenter?.getCurrentBalance()
    }
    
    @IBAction func didTapRateAppButton(_ sender: UIButton) {
        presenter?.didTapRateApp()
    }
    
    @IBAction func didTapShareAppButton(_ sender: UIButton) {
        presenter?.didTapShareApp()
    }
    
    @IBAction func didTapDeleteAccountButton(_ sender: UIButton) {
        presenter?.didTapDeleteAccount()
    }
    
    @IBAction func didTapLogOutButton(_ sender: UIButton) {
        presenter?.didTapSignOut()
    }
}

// MARK: - SettingViewProtocol
extension SettingViewController: SettingViewProtocol {
    
    func showError(_ message: String) {
        showErrorAlert(message: message)
    }
    
    func getCurrentBalance(_ balance: String) {
        userBalanceLabel.text = balance
    }
    
    func getUsername(_ name: String) {
        userNameLabel.text = name
    }
}

// MARK: - setup UI
private extension SettingViewController {
    
    func setupButtons() {
        [rateAppButton, shareAppButton, deleteAccountButton, logOutButton].forEach {
            $0?.rounded(Constants.roundedButton)
            $0?.settingBorder(color: .black, width: Constants.buttonBorderWidth)
            $0?.settingShadow(color: .darkGray, offset: Constants.buttonShadowOffset, radius: Constants.buttonShadowRadius, opacity: Constants.buttonShadowOpacity)
        }
    }
    
    func setupHeaderView() {
        backgroundHeaderView.rounded(Constants.roundedHeaderView)
        backgroundHeaderView.settingShadow(color: .darkGray, offset: Constants.viewShadowOffset, radius: Constants.viewShadowRadius, opacity: Constants.viewShadowOpacity)
    }
}
