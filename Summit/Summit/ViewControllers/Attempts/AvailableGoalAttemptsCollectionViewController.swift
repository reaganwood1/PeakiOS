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
    private var collectionChallenges = CollectionChallenges() // TODO: fix
    private var adapter: ListAdapter?
    
    private let goalService: IGoalService
    
    init(goalService: IGoalService = GoalService()) {
        self.goalService = goalService
        super.init(nibName: nil, bundle: nil)
        availableAttemptsSectionController = AvailableGoalAttemptSectionController(with: self)
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
    
    private func retrieveChallengeAttempts() {
        goalService.getGoalChallenges { [weak self] (result) in
            switch result {
            case .success(let challenges):
                self?.collectionChallenges.goalChallenges.append(contentsOf: challenges)
                self?.adapter?.performUpdates(animated: true, completion: nil)
            case .failure(let error):
                break // TODO: handle the error
            }
        }
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
        return [collectionChallenges]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let availableAttemptsSectionController = availableAttemptsSectionController else {
            return AvailableGoalAttemptSectionController(with: self)
        }
        
        return availableAttemptsSectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// TODO: medium, hard, easy color
extension AvailableGoalAttemptsCollectionViewController: AvailableGoalChallengeDelegate {
    func didSelect(_ challengeId: Int) {
        // TODO: add challenge id
        goalService.postGoalChallenge(withIDOf: challengeId) { (result) in
            switch result {
            case .success:
                // TODO: display alert
                // TODO: implement banner system
                // TODO: show loading indicators
                break
            case .failure(let error):
                // TODO: handle error
                break
            }
        }
    }
}
