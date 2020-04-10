//
//  EmptyStatePresenter.swift
//  Summit
//
//  Created by Reagan Wood on 4/9/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

protocol EmptyStateViewDelegate: class {
    func didPressButton()
}

class EmptyStateView: GenericView {
    
    weak public var delegate: EmptyStateViewDelegate?
    
    // TODO: image
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = .systemFont(ofSize: 30.0, weight: .bold)
        titleLabel.textColor = .textColor
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private let bottomButton: UIButton = {
        let bottomButton = UIButton()
        bottomButton.setTitleColor(.textColor, for: .normal)
        bottomButton.roundCorners(by: 10) // TODO: make this a standard amount in constants
        bottomButton.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
        bottomButton.backgroundColor = .summitObjeckBackground
        bottomButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium) // TODO: add constants
        return bottomButton
    }()
    
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    
    public var buttonText: String = "" {
        didSet {
            bottomButton.setTitle(buttonText, for: .normal)
            addButtonToView()
        }
    }
    
    private func addButtonToView() {
        if bottomButton.superview == nil {
            addSubview(bottomButton)
            createBottomConstraints()
        }
    }
    
    private func createBottomConstraints() {
        if #available(iOS 11.0, *) {
            bottomButton.snp.makeConstraints { (make) in
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(15)
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(50)
            }
        } else {
            bottomButton.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().inset(15)
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(50)
            }
        }
    }
    
    override func initializeUI() {
        super.initializeUI()
        backgroundColor = .summitBackground
        addAllSubviews([imageView, titleLabel])
    }
    
    override func createConstraints() {
        super.createConstraints()
        createImageViewConstraints()
        createTitleLabelConstraints()
    }
    
    private func createImageViewConstraints() {
        let widthAndHeightOfImage = UIScreen.main.bounds.width / 3
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(widthAndHeightOfImage)
        }
    }
    
    private func createTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
    }
    
    @objc private func buttonWasPressed() {
        delegate?.didPressButton()
    }
}
