//
//  SearchVC.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 01/02/25.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView: UIImageView = UIImageView()
    
    let usernameTextField: ZTHBaseTextField = ZTHBaseTextField()
    let actionButton: ZTHFollowerButton     = ZTHFollowerButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    private var tapGesture: UITapGestureRecognizer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        self.configureLogoImageView()
        self.configureTextField()
        self.configureActionButton()
        
        self.configureTapGestureRecognizer()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    private func configureTapGestureRecognizer() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func pushFollowerListVC() {
        let followerListVC      = FollowerListVC()
        followerListVC.username = usernameTextField.text ?? ""
        followerListVC.title    = usernameTextField.text ?? ""
        
        navigationController?.pushViewController(followerListVC, animated: true)
    }

    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: AppConstants.Asset.logoImageName)!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        usernameTextField.delegate = self

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    
    private func configureActionButton() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        actionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
