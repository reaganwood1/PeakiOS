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
        if let collectionView = collectionView {
            addAllSubviews([collectionView])
        }
        
    }
    
    private func initializeCollectionView() {
        layout.delegate = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    override func createConstraints() {
        super.createConstraints()
        collectionView?.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

// SOURCE: https://github.com/MagicLab-team/PinterestLayout
extension AvailableGoalAttemptsView: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        let available: [CGFloat] = [60.0, 90.0, 120.0, 150.0]
        let rand = Int.random(in: 0...3)
        return available[rand]
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        let available: [CGFloat] = [60.0, 90.0, 120.0, 150.0]
        let rand = Int.random(in: 0...3)
        return available[rand]
    }
}
