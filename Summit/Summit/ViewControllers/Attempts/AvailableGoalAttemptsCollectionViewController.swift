//
//  AvailableGoalAttemptsCollectionViewController.swift
//  Summit
//
//  Created by Reagan Wood on 3/20/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit
import IGListKit

class MockAttempt: ListDiffable {
    public let title: String
    
    init(title: String) {
        self.title = title
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return title as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return false
    }
}

class AvailableGoalAttemptsCollectionViewController: GenericViewController<AvailableGoalAttemptsView> {
    private var availableAttempts = [MockAttempt(title: "Hard")]
    private var adapter: ListAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self)
        adapter.collectionView = contentView.collectionView
        adapter.dataSource = self
        self.adapter = adapter
    }
}

extension AvailableGoalAttemptsCollectionViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return availableAttempts
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return AvailableGoalAttemptSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// TODO: medium, hard, easy color
