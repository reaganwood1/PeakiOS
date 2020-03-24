//
//  ActiveGoalsViewController.swift
//  Summit
//
//  Created by Reagan Wood on 3/21/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit
import IGListKit
import Charts

class ActiveAttemptsViewController: GenericViewController<ActiveAttemptCollectionView> {
    private var adapter: ListAdapter?

    private var activeAttempts = [Attempt]()
    
    private let goalService: IGoalService
    
    init(goalService: IGoalService = GoalService()) {
        self.goalService = goalService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        hideNavBar()
        loadAttempts()
    }
    
    private func setupCollectionView() {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self)
        adapter.collectionView = contentView.collectionView
        adapter.dataSource = self
        self.adapter = adapter
    }
    
    private func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func loadAttempts() {
        guard let userID = User.user?.id else {
            print("USER ID NIL")
            return
        }
        
        goalService.getActiveUserGoalAttemps(userID: userID) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let attempts):
                self.activeAttempts = attempts
                self.adapter?.performUpdates(animated: true, completion: nil)
            case .failure(let error):
                break // TODO: handle error
            }
        }
    }
}

extension ActiveAttemptsViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return activeAttempts
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ActiveAttemptsSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
