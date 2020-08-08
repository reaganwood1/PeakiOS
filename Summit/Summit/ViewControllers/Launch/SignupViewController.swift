//
//  SigninViewController.swift
//  Summit
//
//  Created by Reagan Wood on 8/7/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

class SignupViewController: GenericViewController<SignupView> {
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
        changeNavBack(to: "Signup up")
    }
}

extension SignupViewController: SignupViewDelegate {
    func signupPressed(username: String, password: String, email: String) {
        loginService.signup(username: username, password: password, email: email) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.launchRootView()
            case .failure(let error):
                self?.handleAuth(error)
            }
        }
    }
    
    private func launchRootView() {
        let rootVC = RootTabController()
        rootVC.modalPresentationStyle = .fullScreen
        present(rootVC, animated: true, completion: nil)
    }
}
