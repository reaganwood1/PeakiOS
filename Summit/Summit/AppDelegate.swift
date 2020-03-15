//
//  AppDelegate.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        presentRootView()
        return true
    }
    
    private func presentRootView() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = SplashScreenViewController()
        self.window?.makeKeyAndVisible()
    }
}
