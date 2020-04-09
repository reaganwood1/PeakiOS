//
//  SummitNavigationController.swift
//  Summit
//
//  Created by Reagan Wood on 3/28/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

public class SummitNavigationController: UINavigationController {
    private var loginService: ILoginService?
    
    public convenience init(rootViewController: UIViewController, addLogoutButton: Bool, loginService: ILoginService = LoginService()) {
        self.init(rootViewController: rootViewController)
        if addLogoutButton {
            self.loginService = loginService
            addLogoutButtonToNavBar()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    private func addLogoutButtonToNavBar() {
        navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout)) // todo: constants
    }
    
    @objc private func logout() {
        loginService?.logout(completion: { (result) in
            switch result {
            case .success:
                UIApplication.shared.keyWindow?.replaceRootViewControllerWith(LandingScreenViewController(), animated: true, completion: nil)
            case .failure(let error):
                break // TODO: display a banner
            }
        })
    }
    
    private func configureNavBar() {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.summitBackground
        ]
        navigationBar.titleTextAttributes = attributes
        
        navigationBar.tintColor = .summitNavBarBackground
        navigationBar.barTintColor = .summitNavBarBackground
        navigationBar.backgroundColor = .summitNavBarBackground
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.textColor]
        navigationBar.tintColor = .textColor
        navigationBar.isTranslucent = false
    }
}
