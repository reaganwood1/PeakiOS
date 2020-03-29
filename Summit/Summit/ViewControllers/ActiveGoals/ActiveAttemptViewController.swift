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

    private var activeAttempts = UserAttemptsResponse()
    
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
        loadAttempts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        hideNavBar() // TODO: make extension
        changeNavBack(to: "Active") // TODO: constants
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        showNavBar() // TODO: make as an extension
    }
    
    private func setupCollectionView() {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self)
        adapter.collectionView = contentView.collectionView
        adapter.dataSource = self
        self.adapter = adapter
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
                self.updateCollection()
            case .failure(let error):
                break // TODO: handle error
            }
        }
    }
    
    private func updateCollection() {
        adapter?.performUpdates(animated: true, completion: nil)
    }
}

extension ActiveAttemptsViewController: ListAdapterDataSource, ActivateAttemptsSectionControllerDelegate {
    func didSelect(_ attempt: Attempt) {
        let presenter = CompleteAttemptPresenter()
        presenter.present(with: self, { [weak self] in
            self?.completeDaily(attempt)
        })
    }
    
    private func presentAttemptCompletedToday() {
        
    }
    
    private func completeDaily(_ attempt: Attempt) {
        goalService.postUserAttemptEntry(withIDOf: attempt.id, completedToday: true) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let attempt):
                self.activeAttempts.dueSoon = self.activeAttempts.dueSoon.filter({ $0.id != attempt.id })
                self.activeAttempts.completedToday.append(attempt)
                self.updateCollection()
                // TODO: alert for completed
            case .failure(let error):
                break // TODO: complete error
            }
        }
    }
    
    func shouldShowHeader(for attempt: Attempt) -> Bool {
        if let firstCompleted = activeAttempts.completedToday.first, firstCompleted.id == attempt.id {
            return true
        } else if let firstNeedsCompletedToday = activeAttempts.dueSoon.first, firstNeedsCompletedToday.id == attempt.id {
            return true
        } else {
            return false
        }
    }
    
    func getHeaderText(for attempt: Attempt) -> String {
        if let firstCompleted = activeAttempts.completedToday.first, firstCompleted.id == attempt.id {
            return "Completed today" // TODO: constants
        } else {
            return "Due soon" // TODO: constants
        }
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return activeAttempts.completedToday + activeAttempts.dueSoon
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ActiveAttemptsSectionController(withDelegate: self)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
