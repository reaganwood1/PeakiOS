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

protocol LandingScreenViewDelegate: class {
    func getStartedPressed()
    func signupPressed()
}

// TODO: reimpliment FACEBOOK SDK after COVID
class LandingScreenView: GenericView {
    weak public var delegate: (LoginButtonDelegate & LandingScreenViewDelegate)? {
        didSet {
//            facebookLoginButton.delegate = delegate
        }
    }
    
    private let bannerLabel: UILabel = {
        let bannerLabel = UILabel()
        bannerLabel.textColor = .summitBackground
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
    
//    private let facebookLoginButton: FBLoginButton = {
//        let facebookLoginButton = FBLoginButton()
//        facebookLoginButton.layer.cornerRadius = 10.0
//        facebookLoginButton.addButtonShadow()
//        facebookLoginButton.alpha = 0.0
//        return facebookLoginButton
//    }()
    
    private let getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .summitBackground
        button.addButtonShadow()
        button.layer.cornerRadius = 10.0
        button.setTitleColor(.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        button.addTarget(self, action: #selector(getStartedPressed), for: .touchUpInside)
        button.alpha = 0.0
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Signup", for: .normal)
        button.backgroundColor = .textColor
        button.addButtonShadow()
        button.layer.cornerRadius = 10.0
        button.setTitleColor(.summitBackground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        button.addTarget(self, action: #selector(signupPressed), for: .touchUpInside)
        button.alpha = 0.0
        return button
    }()
    
    public override func initializeUI() {
        super.initializeUI()
//        addAllSubviews([backgroundImageView, facebookLoginButton, bannerLabel, bannerSubLabel])
        addAllSubviews([backgroundImageView, getStartedButton, signupButton, bannerLabel, bannerSubLabel])
        sendSubviewToBack(backgroundImageView)
    }
    
    public override func createConstraints() {
        super.createConstraints()
        createBackgroundImageViewConstraints()
//        removeFacebookButtonHeightConstraint()
        createConstraintsForFacebookButton()
        createConstraintsForBannerLabel()
        createConstraintsForBannerSubLabel()
    }
    
    private func createBackgroundImageViewConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
//    private func removeFacebookButtonHeightConstraint() {
//        if let buttonHeightConstraint = facebookLoginButton.constraints.first(where: { $0.firstAttribute == .height }) {
//            facebookLoginButton.removeConstraint(buttonHeightConstraint)
//            facebookLoginButton.removeConstraint(buttonHeightConstraint)
//        }
//    }
    
    private func createConstraintsForFacebookButton() {
        let paddingFromSides: CGFloat = 15.0
        let distanceBetweenButtons: CGFloat = 10.0
        let smallerButtonWidth: CGFloat = (UIScreen.main.bounds.width - paddingFromSides * 2 - distanceBetweenButtons) / 3.0
        
        if #available(iOS 11.0, *) {
//            facebookLoginButton.snp.makeConstraints { (make) in
//                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
//                make.left.right.equalToSuperview().inset(15)
//                make.height.equalTo(50)
//            }
            getStartedButton.snp.makeConstraints { (make) in
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
                make.left.equalToSuperview().inset(paddingFromSides)
                make.width.equalTo(smallerButtonWidth * 2)
                make.height.equalTo(50)
            }
            signupButton.snp.makeConstraints { (make) in
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
                make.right.equalToSuperview().inset(paddingFromSides)
                make.width.equalTo(smallerButtonWidth)
                make.height.equalTo(50)
            }
        } else {
//            facebookLoginButton.snp.makeConstraints { (make) in
//                make.bottom.equalToSuperview().inset(15)
//                make.left.right.equalToSuperview().inset(15)
//                make.height.equalTo(50)
//            }
            getStartedButton.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().inset(15)
                make.left.equalToSuperview().inset(paddingFromSides)
                make.width.equalTo(smallerButtonWidth * 2)
                make.height.equalTo(50)
            }
            signupButton.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().inset(15)
                make.right.equalToSuperview().inset(paddingFromSides)
                make.width.equalTo(smallerButtonWidth)
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
//        facebookLoginButton.isHidden = true
        getStartedButton.isHidden = true
    }
    
    public func configureForNetworkComplete() {
        // TODO: remove an activity indicator
//        facebookLoginButton.isHidden = false
        getStartedButton.isHidden = false
    }
    
    public func animateToFinalPositions() {
        UIView.animate(withDuration: 1.75) { [weak self] in
            guard let self = self else { return }
            self.bannerLabel.alpha = 1.0
            self.bannerSubLabel.alpha = 1.0
            self.getStartedButton.alpha = 1.0
            self.signupButton.alpha = 1.0
//            self.facebookLoginButton.alpha = 1.0
        }
    }
    
    @objc private func getStartedPressed() {
        delegate?.getStartedPressed()
    }
    
    @objc private func signupPressed() {
        delegate?.signupPressed()
    }
}
