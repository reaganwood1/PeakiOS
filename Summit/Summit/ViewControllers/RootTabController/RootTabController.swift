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
    }
    
    private func makeTopicsViewController() -> UIViewController {
        let topicsVC = GoalCollectionViewController()

        let vc = SummitNavigationController(rootViewController: topicsVC)
        let tabBarItem = UITabBarItem(title: "Topics", image: nil, selectedImage: nil) // TODO: l10
        tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11.0, weight: .semibold)
            ], for: UIControl.State())
        vc.tabBarItem = tabBarItem
        return vc
    }
    
    private func makeUserAttemptsViewController() -> UIViewController {
        let activeVC = ActiveAttemptsViewController()

        let vc = SummitNavigationController(rootViewController: activeVC)
        let tabBarItem = UITabBarItem(title: "Active", image: nil, selectedImage: nil) // TODO: l10
        tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11.0, weight: .semibold)
            ], for: UIControl.State())
        vc.tabBarItem = tabBarItem
        return vc
    }
    
    private func configureTab() {
        tabBar.backgroundColor = .black
        tabBar.tintColor = .offWhite
        tabBar.barTintColor = .black
    }
}
