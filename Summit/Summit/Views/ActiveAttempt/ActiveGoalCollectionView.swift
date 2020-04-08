//
//  ActiveGoalCollectionView.swift
//  Summit
//
//  Created by Reagan Wood on 3/23/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

class ActiveAttemptCollectionView: GenericView {
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .summitBackground
        return collectionView
    }()
    
    override func initializeUI() {
        super.initializeUI()
        addAllSubviews([collectionView])
    }
    
    override func createConstraints() {
        super.createConstraints()
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}
