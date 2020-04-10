//
//  RootTabController.swift
//  Summit
//
//  Created by Reagan Wood on 3/28/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

class RootTabController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        let topicsVC = makeTopicsViewController()
        let userAttemptsVC = makeUserAttemptsViewController()
        self.viewControllers = [topicsVC, userAttemptsVC]
    }
    
    required init?(coder: NSCoder) {
        print("DO NOT CREATE ME FROM THE STORYBOARD")
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTab()
        setRootVC(to: self)
    }
    
    private func makeTopicsViewController() -> UIViewController {
        let topicsVC = GoalCollectionViewController()

        let vc = SummitNavigationController(rootViewController: topicsVC)
        let tabBarItem = UITabBarItem(title: "Topics", image: #imageLiteral(resourceName: "imgTopicsTabBarSelected"), selectedImage: #imageLiteral(resourceName: "imgTopicsTabBarSelected")) // TODO: l10
        tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11.0, weight: .semibold)
            ], for: UIControl.State())
        vc.tabBarItem = tabBarItem
        return vc
    }
    
    private func makeUserAttemptsViewController() -> UIViewController {
        let activeVC = ActiveAttemptsViewController()

        let vc = SummitNavigationController(rootViewController: activeVC, addLogoutButton: true)
        let tabBarItem = UITabBarItem(title: "Active", image: #imageLiteral(resourceName: "imgActiveAttempts"), selectedImage: #imageLiteral(resourceName: "imgActiveAttempts")) // TODO: l10
        tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11.0, weight: .semibold)
            ], for: UIControl.State())
        vc.tabBarItem = tabBarItem
        return vc
    }
    
    private func configureTab() {
        tabBar.backgroundColor = .summitNavBarBackground
        tabBar.tintColor = .textColor
        tabBar.barTintColor = .summitNavBarBackground
        tabBar.unselectedItemTintColor = .textColor
        tabBar.isTranslucent = false
    }
}
