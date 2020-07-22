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
    
    public enum NavButtonType {
        case dismiss
        case logout
    }
    
    public convenience init(rootViewController: UIViewController, buttonType: NavButtonType, loginService: ILoginService = LoginService()) {
        self.init(rootViewController: rootViewController)
        
        switch buttonType {
        case .dismiss:
            addButtonToNavBar(buttonType: buttonType)
        case .logout:
            self.loginService = loginService
            addButtonToNavBar(buttonType: buttonType)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    private func addButtonToNavBar(buttonType: NavButtonType) {
        switch buttonType {
        case .dismiss:
            navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .done, target: self, action: #selector(dismissPressed)) // todo: constants
        case .logout:
            navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout)) // todo: constants
        }
    }
    
    @objc private func dismissPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func logout() {
        loginService?.logout(completion: { [weak self] (result) in
            switch result {
            case .success:
                let navController = SummitNavigationController(rootViewController: LandingScreenViewController())
                UIApplication.shared.keyWindow?.replaceRootViewControllerWith(navController, animated: true, completion: nil)
            case .failure(let error):
                switch error {
                case .noNetwork:
                    self?.creatErrorBanner(with: Strings.General.NoNetwork).show()
                case .serverError:
                    self?.creatErrorBanner(with: Strings.General.UnknownErrorTryAgain).show()
                }
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
