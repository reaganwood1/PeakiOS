//
//  LandingScreenView.swift
//  Summit
//
//  Created by Reagan Wood on 3/15/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LandingScreenView: GenericView {
    weak public var delegate: LoginButtonDelegate? {
        didSet {
            facebookLoginButton.delegate = delegate
        }
    }
    
    private let backgroundImageView: UIImageView = {
        let backroundImageView = UIImageView(image: #imageLiteral(resourceName: "landingImage"))
        backroundImageView.contentMode = .scaleAspectFill
        return backroundImageView
    }()
    
    private let facebookLoginButton: FBLoginButton = {
        let facebookLoginButton = FBLoginButton()
        facebookLoginButton.layer.cornerRadius = 10.0
        facebookLoginButton.addButtonShadow()
        return facebookLoginButton
    }()
    
    public override func initializeUI() {
        super.initializeUI()
        addAllSubviews([backgroundImageView, facebookLoginButton])
        sendSubviewToBack(backgroundImageView)
    }
    
    public override func createConstraints() {
        super.createConstraints()
        createBackgroundImageViewConstraints()
        removeFacebookButtonHeightConstraint()
        createConstraintsForFacebookButton()
    }
    
    private func createBackgroundImageViewConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func removeFacebookButtonHeightConstraint() {
        if let buttonHeightConstraint = facebookLoginButton.constraints.first(where: { $0.firstAttribute == .height }) {
            facebookLoginButton.removeConstraint(buttonHeightConstraint)
        }
    }
    
    private func createConstraintsForFacebookButton() {
        if #available(iOS 11.0, *) {
            facebookLoginButton.snp.makeConstraints { (make) in
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(15)
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(50)
            }
        } else {
            facebookLoginButton.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(50)
            }
        }
    }
    
    public func configureForNetwork() {
        // TODO: add an activity indicator
        facebookLoginButton.isHidden = true
    }
    
    public func configureForNetworkComplete() {
        // TODO: remove an activity indicator
        facebookLoginButton.isHidden = false
    }
}
