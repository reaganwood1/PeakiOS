//
//  SummitNavigationController.swift
//  Summit
//
//  Created by Reagan Wood on 3/28/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

public class SummitNavigationController: UINavigationController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    private func configureNavBar() {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.offWhite
        ]
        navigationBar.titleTextAttributes = attributes
        
        navigationBar.tintColor = .offWhite
        navigationBar.barTintColor = .black
        navigationBar.backgroundColor = .black
    }
}
