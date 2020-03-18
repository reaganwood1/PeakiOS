//
//  SplashScreenViewController.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SplashScreenViewController: GenericViewController<SplashScreenView> {
    private let loginService: ILoginService
    
    init(loginService: ILoginService = LoginService()) {
        self.loginService = loginService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        determineLaunchScreen()
    }
    
    private func determineLaunchScreen() {
        if let accessTokenAndUser = getPersistedUserToken() {
            launchSession(from: accessTokenAndUser.0, for: accessTokenAndUser.1)
        } else {
            launchLandingScreen()
            
        }
    }
    
    private func getPersistedUserToken() -> (AccessToken, UserId)? {
        if let accessToken = KeychainWrapper.standard.string(forKey: Strings.Code.AccessToken), let userId = KeychainWrapper.standard.string(forKey: Strings.Code.UserId) {
            return (accessToken, userId)
        }
        
        return nil
    }
    
    private func launchSession(from accessToken: String, for userID: String) {
        loginService.userFrom(accessToken, for: userID) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.launchRootView()
            case .failure(_):
                break
            }
        }
    }
    
    private func launchRootView() {
        let vc = GoalCollectionViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    private func launchLandingScreen() {
        let vc = LandingScreenViewController()
        let navController = UINavigationController(rootViewController: vc)
        DispatchQueue.main.async { [weak self] in
            navController.modalPresentationStyle = .overFullScreen
            self?.present(navController, animated: false, completion: nil)
        }
    }
    
    private func loginUser() {
        let username = ""
        let password = ""
        loginService.login(username: username, password: password) { (result) in
            switch result {
            case .success(_):
                
                break
            case .failure(_):
                break
            }
        }
    }
}

