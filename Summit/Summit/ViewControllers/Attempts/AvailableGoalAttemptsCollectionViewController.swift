//
//  AvailableGoalAttemptsCollectionViewController.swift
//  Summit
//
//  Created by Reagan Wood on 3/20/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit
import IGListKit
import Charts

class AvailableGoalAttemptsCollectionViewController: GenericViewController<AvailableGoalAttemptsView> {
    private var adapter: ListAdapter?
    
    private let goalService: IGoalService
    private let topic: Goal
    
    private var challenges = CollectionChallenges()
    
    init(with topic: Goal, goalService: IGoalService = GoalService()) {
        self.goalService = goalService
        self.topic = topic
        super.init(nibName: nil, bundle: nil)
        availableAttemptsSectionController = AvailableGoalAttemptSectionController()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private var availableAttemptsSectionController: AvailableGoalAttemptSectionController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        retrieveChallengeAttempts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeNavBack(to: "Challenges") // TODO: constantsx
    }
    
    private func retrieveChallengeAttempts() {
        goalService.getAvailableChallenges(for: topic) { [weak self] (result) in
            switch result {
            case .success(let challenges):
                self?.challenges.goalChallenges = challenges
                self?.reloadCollectionView()
            case .failure(let error):
                break // TODO: handle the error
            }
        }
    }
    
    private func reloadCollectionView() {
        adapter?.performUpdates(animated: true, completion: nil)
    }
    
    private func setupCollectionView() {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self)
        adapter.collectionView = contentView.collectionView
        adapter.dataSource = self
        self.adapter = adapter
        contentView.delegate = availableAttemptsSectionController
    }
}

extension AvailableGoalAttemptsCollectionViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [challenges]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let availableAttemptsSectionController = availableAttemptsSectionController else {
            return AvailableGoalAttemptSectionController()
        }
        
        return availableAttemptsSectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
