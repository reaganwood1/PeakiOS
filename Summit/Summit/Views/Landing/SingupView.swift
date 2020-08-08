//
//  SingupView.swift
//  Summit
//
//  Created by Reagan Wood on 8/8/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

protocol SignupViewDelegate: class {
    func signupPressed(username: String, password: String, email: String)
}

class SignupView: GenericView {
    weak public var delegate: SignupViewDelegate?
    
    private let viewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create an account!"
        label.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        label.textColor = .textColor
        return label
    }()
    
    private let usernameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .textColor
        return label
    }()
    
    private let usernameField: UITextField = {
        let usernameField = UITextField()
        usernameField.placeholder = "Enter a username"
        usernameField.font = .systemFont(ofSize: 14.0)
        usernameField.textColor = .textColor
        usernameField.tintColor = .textColor
        usernameField.autocapitalizationType = .none
        return usernameField
    }()
    
    private let passwordTitleLabel: UILabel = {
        let passwordTitleLabel = UILabel()
        passwordTitleLabel.text = "Password"
        passwordTitleLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        passwordTitleLabel.textColor = .textColor
        return passwordTitleLabel
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Create a password"
        passwordTextField.textColor = .textColor
        passwordTextField.font = .systemFont(ofSize: 14.0)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.tintColor = .textColor
        passwordTextField.autocapitalizationType = .none
        return passwordTextField
    }()
    
    private let emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .textColor
        return label
    }()
    
    private let emailField: UITextField = {
        let usernameField = UITextField()
        usernameField.placeholder = "Enter an email"
        usernameField.font = .systemFont(ofSize: 14.0)
        usernameField.textColor = .textColor
        usernameField.tintColor = .textColor
        usernameField.autocapitalizationType = .none
        return usernameField
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Signup and continue", for: .normal)
        button.backgroundColor = .summitObjeckBackground
        button.layer.cornerRadius = 10.0
        button.setTitleColor(.textColor, for: .normal)
        button.addTarget(self, action: #selector(signupPressed), for: .touchUpInside)
        return button
    }()
    
    override func initializeUI() {
        setDelegates()
        addAllSubviews([viewTitleLabel, usernameTitleLabel, usernameTitleLabel, usernameField, passwordTitleLabel, passwordTextField, signupButton, emailTitleLabel, emailField])
    }
    
    private func setDelegates() {
        usernameField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func createConstraints() {
        super.createConstraints()
        createViewTitleLabelConstraints()
        createUsernameTitleConstraints()
        createUsernameFieldConstraints()
        createPasswordTitleLabelConstraints()
        createPasswordTitleFieldConstraints()
        createEmailTitleLabelConstraints()
        createEmailFieldConstraints()
        createSignupButtonConstraints()
    }
    
    private func createViewTitleLabelConstraints() {
        viewTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(40)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
    private func createUsernameTitleConstraints() {
        usernameTitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(viewTitleLabel.snp.bottom).offset(30)
        }
    }
    
    private func createUsernameFieldConstraints() {
        usernameField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(usernameTitleLabel.snp.bottom).offset(5)
        }
    }
    
    private func createPasswordTitleLabelConstraints() {
        passwordTitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(usernameField.snp.bottom).offset(15)
        }
    }
    
    private func createPasswordTitleFieldConstraints() {
        passwordTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(5)
        }
    }
    
    private func createEmailTitleLabelConstraints() {
        emailTitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
        }
    }
    
    private func createEmailFieldConstraints() {
        emailField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(5)
        }
    }
    
    private func createSignupButtonConstraints() {
        signupButton.snp.makeConstraints { (make) in
            make.top.equalTo(emailField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
    }
    
    @objc private func signupPressed() {
        delegate?.signupPressed(username: usernameField.text ?? "", password: passwordTextField.text ?? "", email: emailField.text ?? "")
    }
}

extension SignupView: UITextFieldDelegate {
}

