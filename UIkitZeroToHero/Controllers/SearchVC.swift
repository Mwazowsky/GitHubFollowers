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
    let validationLabel: ZTHValidationText  = ZTHValidationText()
    
    var isUsernameEnterd: Bool { return !usernameTextField.text!.isEmpty }
    
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
        guard let githubUsernameText = usernameTextField.text, !githubUsernameText.isEmpty else {
            print("No Username entered")
            return
        }
        
        if githubUsernameText.isValidGithubUsername {
            let followerListVC = FollowerListVC()
            followerListVC.username = githubUsernameText
            followerListVC.title = githubUsernameText
            navigationController?.pushViewController(followerListVC, animated: true)
        } else {
            print("Invalid Username format")
        }
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        validateCurrentInput()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateCurrentInput()
    }
    
    
    private func validateCurrentInput() {
        let text = usernameTextField.text ?? ""
        
        if text.isEmpty {
            actionButton.isEnabled = false
            validationLabel.setValidationStatus(.empty)
        } else if !text.isValidGithubUsername {
            validationLabel.setValidationStatus(.invalid(["Invalid username format", "Use only alphanumeric characters and hyphens"]))
        } else {
            actionButton.isEnabled = true
            validationLabel.setValidationStatus(.valid)
        }
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
        view.addSubview(validationLabel)
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        validationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // Validation label constraints
            validationLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 8),
            validationLabel.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            validationLabel.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor)
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
