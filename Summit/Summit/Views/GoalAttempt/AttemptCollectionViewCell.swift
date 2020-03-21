//
//  AttemptCollectionViewCell.swift
//  Summit
//
//  Created by Reagan Wood on 3/21/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

// TODO: own class
class AttemptCollectionViewCell: UICollectionViewCell {
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryBlack
        return view
    }()
    
    private let difficultyLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .darkBlue
        titleLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
        return titleLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.textColor = .offWhite
        subtitleLabel.font = .systemFont(ofSize: 14.0, weight: .medium)
        return subtitleLabel
    }()
    
    private let actionButton: UIButton = {
        let actionButton = UIButton()
        actionButton.setTitle("Add", for: .normal)
        actionButton.setTitleColor(.darkBlue, for: .normal)
        actionButton.backgroundColor = .backgroundBlack
        actionButton.layer.cornerRadius = 10.0 // TODO: Implement as a global constant
        return actionButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeUI()
    }
    
    private func initializeUI() {
        backgroundColor = .backgroundBlack
        topContainerView.addAllSubviews([difficultyLabel, actionButton])
        addAllSubviews([topContainerView, descriptionLabel])
        createConstraints()
        roundCorners()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: topContainerView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        topContainerView.layer.mask = maskLayer // TODO: hlper
    }
    
    private func roundCorners() {
        layer.cornerRadius = 10.0
    }
    
    private func createConstraints() {
        topContainerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(75)
        }
        
        difficultyLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topContainerView.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(15)
        }
        
        actionButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(50)
        }
    }
    
    public func set(titleTo title: String, andSubtitleTo subtitle: String) {
        difficultyLabel.text = title
        descriptionLabel.text = subtitle
    }
}
