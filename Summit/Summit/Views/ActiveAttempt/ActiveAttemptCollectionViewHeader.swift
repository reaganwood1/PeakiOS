//
//  ActiveAttemptCollectionViewHeader.swift
//  Summit
//
//  Created by Reagan Wood on 3/28/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

class ActiveAttemptCollectionViewHeader: UICollectionReusableView {

    public var headerText: String = "" {
        didSet {
            headerLabel.text = headerText
        }
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .offWhite
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeUI()
    }

    private func initializeUI() {
        self.addSubview(headerLabel)
        backgroundColor = .backgroundBlack
        createConstraints()
    }

    private func createConstraints() {
        headerLabel.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
    }
}
