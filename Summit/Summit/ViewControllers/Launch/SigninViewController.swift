//
//  SigninViewController.swift
//  Summit
//
//  Created by Reagan Wood on 3/15/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

class SigninViewController: GenericViewController<SigninView> {
    private let loginService: ILoginService
    
    init(loginService: ILoginService = LoginService()) {
        self.loginService = loginService
        super.init(nibName: nil, bundle: nil)
        contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeNavBack(to: "Sign in")
    }
}

extension SigninViewController: SigninViewDelegate {
    func loginPressed(username: String, password: String) {
        loginService.login(username: username, password: password) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.launchRootView()
            case .failure(let error):
                switch error {
                case .noNetwork:
                    break
                    // TODO: handle no network connect
                case .serverError:
                    break
                    // TODO: handle error
                }
            }
        }
    }
    
    private func launchRootView() {
        let rootVC = RootTabController()
        rootVC.modalPresentationStyle = .fullScreen
        present(rootVC, animated: true, completion: nil)
    }
}

protocol SigninViewDelegate: class {
    func loginPressed(username: String, password: String)
}

class SigninView: GenericView {
    weak public var delegate: SigninViewDelegate?
    
    private let viewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Time to get started!"
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
        passwordTextField.placeholder = "Enter a password"
        passwordTextField.textColor = .textColor
        passwordTextField.font = .systemFont(ofSize: 14.0)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        return passwordTextField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .summitObjeckBackground
        button.addButtonShadow()
        button.layer.cornerRadius = 10.0
        button.setTitleColor(.textColor, for: .normal)
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        return button
    }()
    
    override func initializeUI() {
        setDelegates()
        addAllSubviews([viewTitleLabel, usernameTitleLabel, usernameTitleLabel, usernameField, passwordTitleLabel, passwordTextField, loginButton])
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
        createLoginButtonConstraints()
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
    
    private func createLoginButtonConstraints() {
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
    }
    
    @objc private func loginPressed() {
        delegate?.loginPressed(username: usernameField.text ?? "", password: passwordTextField.text ?? "")
    }
}

extension SigninView: UITextFieldDelegate {
}

