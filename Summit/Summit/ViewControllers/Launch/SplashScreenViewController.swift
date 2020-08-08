//
//  SplashScreenViewController.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

class SplashScreenViewController: GenericViewController<SplashScreenView> {
    private let loginService: ILoginService
    private let tokenCache: ITokenCache
    
    init(loginService: ILoginService = LoginService(), tokenCache: ITokenCache = TokenCache()) {
        self.loginService = loginService
        self.tokenCache = tokenCache
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
        guard let cachedCredentials = tokenCache.getCachedLoginToken() else {
            launchLandingScreen()
            return
        }
        
        launchSession(from: cachedCredentials.0, for: cachedCredentials.1)
    }
    
    private func launchSession(from accessToken: String, for userID: UserId) {
        loginService.userFrom(accessToken, for: userID) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.launchRootView()
            case .failure(_):
                self?.launchLandingScreen()
            }
        }
    }
    
    private func launchRootView() {
        let rootVC = RootTabController()
        rootVC.modalPresentationStyle = .fullScreen
        present(rootVC, animated: true, completion: nil)
    }
    
    private func launchLandingScreen() {
        let vc = LandingScreenViewController()
        let navController = SummitNavigationController(rootViewController: vc)
        DispatchQueue.main.async { [weak self] in
            navController.modalPresentationStyle = .overFullScreen
            self?.present(navController, animated: false, completion: nil)
        }
    }
    
    private func loginUser() {
        let username = ""
        let password = ""
        loginService.login(username: username, password: password) { [weak self] (result) in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self?.handleAuth(error)
            }
        }
    }
}

