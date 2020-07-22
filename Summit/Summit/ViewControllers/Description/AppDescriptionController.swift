//
//  AppDescriptionController.swift
//  Summit
//
//  Created by Reagan Wood on 7/22/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

class AppDescriptionController: GenericViewController<AppDescriptionView> {
}

class AppDescriptionView: GenericView {
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .textColor
        descriptionLabel.text = "Peak exists to help you reach your goals. This is for helping you learn how to get started. Select a topic and associated challenge you would like to make daily progress towards. For that challenge, come back daily and complete it until it's finished. Good luck!\n\nThis is an app in progress and many things will be updated in the future!"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        return descriptionLabel
    }()
    
    override func initializeUI() {
        super.initializeUI()
        addSubview(descriptionLabel)
    }
    
    override func createConstraints() {
        super.createConstraints()
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(30)
        }
    }
}
