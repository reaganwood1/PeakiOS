//
//  LandingScreenView.swift
//  Summit
//
//  Created by Reagan Wood on 3/15/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

class LandingScreenView: GenericView {
    weak public var delegate: LandingScreenViewDelegate?
    
    private let backroundImageView: UIImageView = {
        let backroundImageView = UIImageView(image: #imageLiteral(resourceName: "landingImage"))
        backroundImageView.contentMode = .scaleAspectFill
        return backroundImageView
    }()
    
    private let landingButton: UIButton = {
        let landingButton = UIButton()
        landingButton.setTitle("Lets get started", for: .normal)
        landingButton.setTitleColor(.black, for: .normal)
        landingButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        landingButton.backgroundColor = .white
        landingButton.layer.cornerRadius = 10.0
        landingButton.addButtonShadow()
        landingButton.addTarget(self, action: #selector(getStartedButtonPressed), for: .touchUpInside)
        return landingButton
    }()
    
    public override func initializeUI() {
        super.initializeUI()
        addAllSubviews([backroundImageView, landingButton])
        sendSubviewToBack(backroundImageView)
    }
    
    @objc private func getStartedButtonPressed() {
        delegate?.didPressGetStarted()
    }
    
    public override func createConstraints() {
        super.createConstraints()
        createBackroundImageViewConstraints()
        createConstraintsForLandingButton()
    }
    
    private func createBackroundImageViewConstraints() {
        backroundImageView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func createConstraintsForLandingButton() {
        if #available(iOS 11.0, *) {
            landingButton.snp.makeConstraints { (make) in
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(15)
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(50)
            }
        } else {
            landingButton.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(50)
            }
        }
    }
}
