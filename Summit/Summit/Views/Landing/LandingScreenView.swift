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
    
    private let bannerLabel: UILabel = {
        let bannerLabel = UILabel()
        bannerLabel.textColor = .textColor
        bannerLabel.font = .systemFont(ofSize: 50.0, weight: .bold)
        bannerLabel.text = "Peak."
        bannerLabel.alpha = 0.0
        return bannerLabel
    }()
    
    private let bannerSubLabel: UILabel = {
        let bannerSubLabel = UILabel()
        bannerSubLabel.textColor = .textColor
        bannerSubLabel.font = .systemFont(ofSize: 25.0, weight: .bold)
        bannerSubLabel.text = "Keep moving forward"
        bannerSubLabel.alpha = 0.0
        return bannerSubLabel
    }()
    
    private let backgroundImageView: UIImageView = {
        let backroundImageView = UIImageView(image: #imageLiteral(resourceName: "landingImage"))
        backroundImageView.contentMode = .scaleAspectFill
        return backroundImageView
    }()
    
    private let facebookLoginButton: FBLoginButton = {
        let facebookLoginButton = FBLoginButton()
        facebookLoginButton.layer.cornerRadius = 10.0
        facebookLoginButton.addButtonShadow()
        facebookLoginButton.alpha = 0.0
        return facebookLoginButton
    }()
    
    public override func initializeUI() {
        super.initializeUI()
        addAllSubviews([backgroundImageView, facebookLoginButton, bannerLabel, bannerSubLabel])
        sendSubviewToBack(backgroundImageView)
    }
    
    public override func createConstraints() {
        super.createConstraints()
        createBackgroundImageViewConstraints()
        removeFacebookButtonHeightConstraint()
        createConstraintsForFacebookButton()
        createConstraintsForBannerLabel()
        createConstraintsForBannerSubLabel()
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
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(50)
            }
        } else {
            facebookLoginButton.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().inset(15)
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(50)
            }
        }
    }
    
    private func createConstraintsForBannerLabel() {
        bannerLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(75)
            make.left.equalToSuperview().inset(15)
        }
    }
    
    private func createConstraintsForBannerSubLabel() {
        bannerSubLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bannerLabel.snp.bottom).offset(5)
            make.left.equalTo(bannerLabel.snp.left)
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
    
    public func animateToFinalPositions() {
        UIView.animate(withDuration: 1.75) { [weak self] in
            guard let self = self else { return }
            self.bannerLabel.alpha = 1.0
            self.bannerSubLabel.alpha = 1.0
            self.facebookLoginButton.alpha = 1.0
        }
    }
}
