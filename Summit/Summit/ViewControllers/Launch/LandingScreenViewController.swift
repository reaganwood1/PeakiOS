//
//  LandingScreenViewController.swift
//  Summit
//
//  Created by Reagan Wood on 3/15/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LandingScreenViewController: GenericViewController<LandingScreenView> {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutExistingData()
        setDelegate()
    }
    
    private func logoutExistingData() {
        loginService.logout(completion: {_ in })
    }
    
    private func setDelegate() {
        contentView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.animateToFinalPositions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavBar()
    }
}

extension LandingScreenViewController: LoginButtonDelegate, LandingScreenViewDelegate {
    func getStartedPressed() {
        navigationController?.pushViewController(SigninViewController(), animated: true)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let result = result else { return }
        if let error = error {
            // TODO: handle error
            return
        }
        
        guard let token = result.token else {
            // TODO: configure view
            return
        }
        
        tokenCache.cacheToken(token: .facebookToken(token.tokenString))
        
        contentView.configureForNetwork()
        
        loginService.socialUserFrom(token.tokenString, provider: .facebook) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.launchRootView()
            case .failure(_):
                self?.contentView.configureForNetworkComplete()
                break // TODO: handle error
            }
        }
    }
    
    private func launchRootView() {
        let rootVC = RootTabController()
        rootVC.modalPresentationStyle = .fullScreen
        present(rootVC, animated: true, completion: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // TODO: handle logout in your app
    }
}
