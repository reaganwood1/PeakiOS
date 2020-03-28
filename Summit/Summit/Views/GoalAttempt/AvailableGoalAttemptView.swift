//
//  AvailableGoalAttemptView.swift
//  Summit
//
//  Created by Reagan Wood on 3/21/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

class AvailableGoalAttemptsView: GenericView {
    private let itemsPerRow: Int = 2
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let collectionViewInsetFromTop: CGFloat = 15.0
    
    weak public var delegate: PinterestLayoutDelegate? {
        didSet{
            if let delegate = delegate {
                layout.delegate = delegate
            }
        }
    }
    
    private let layout: PinterestLayout = {
        let layout = PinterestLayout()
        layout.cellPadding = 5
        layout.numberOfColumns = 2
        return layout
    }()
    
    public var collectionView: UICollectionView?
    
    override func initializeUI() {
        super.initializeUI()
        initializeCollectionView()
        backgroundColor = .backgroundBlack
        if let collectionView = collectionView {
            addAllSubviews([collectionView])
        }
        changeTopCollectionViewInsets()
    }
    
    private func initializeCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .backgroundBlack
    }
    
    override func createConstraints() {
        super.createConstraints()
        collectionView?.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func changeTopCollectionViewInsets() {
        collectionView?.contentInset.top = collectionViewInsetFromTop
    }
}
