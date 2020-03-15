//
//  LandingScreenViewController.swift
//  Summit
//
//  Created by Reagan Wood on 3/15/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

class LandingScreenViewController: GenericViewController<LandingScreenView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: handle one button press that launches a screen to proceed into the app
        setDelegate()
    }
    
    private func setDelegate() {
        contentView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

extension LandingScreenViewController: LandingScreenViewDelegate {
    func didPressGetStarted() {
        // TODO: present the main signin view.
    }
}

protocol LandingScreenViewDelegate: class {
    func didPressGetStarted()
}
