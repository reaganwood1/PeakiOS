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
    private let topContainerHeight: CGFloat = 45
    private let contentPadding: CGFloat = 15
    
    weak private var delegate: AvailableGoalChallengeDelegate?
    
    public var challengeId: Int?
    
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
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        return subtitleLabel
    }()
    
    private let actionButton: UIButton = {
        let actionButton = UIButton()
        actionButton.setTitle("Add", for: .normal)
        actionButton.setTitleColor(.darkBlue, for: .normal)
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
        actionButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
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
            make.height.equalTo(topContainerHeight)
        }
        
        difficultyLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topContainerView.snp.bottom).offset(10)
            make.right.left.equalToSuperview().inset(15)
        }
        
        actionButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func addButtonTapped() {
        guard let challengeId = challengeId else {
            print("challenge id had not been set")
            return
        }
        
        delegate?.didSelect(challengeId)
    }
    
    public func getHeightForCell(withWidthOf width: CGFloat) -> CGFloat {
        let descriptionHeight = descriptionLabel.text?.height(withWidth: width, font: descriptionLabel.font) ?? 0
        return topContainerHeight + (contentPadding * 3) + descriptionHeight
    }
    
    public func set(titleTo title: String, andSubtitleTo subtitle: String, challengeId: Int, and delegate: AvailableGoalChallengeDelegate?) {
        self.delegate = delegate
        difficultyLabel.text = title
        descriptionLabel.text = subtitle
        self.challengeId = challengeId
    }
}
