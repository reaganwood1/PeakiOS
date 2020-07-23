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

class AllAttemptsViewController: GenericViewController<ActiveAttemptCollectionView> {
    private var adapter: ListAdapter?
    
    private var emptyStatePresenter = EmptyStatePresenter()

    private var allAttempts = UserAttemptsResponse()
    
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
        subscribeForUpdateAttempts()
        loadAttempts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeNavBack(to: "Attempts") // TODO: constants
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
        
        goalService.getAllUserGoalAttemps(userID: userID) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let attempts):
                self.handleRetrieved(attempts)
            case .failure(_):
                self.addNoInternetEmptyState()
            }
        }
    }
    
    private func handleRetrieved(_ attempts: UserAttemptsResponse) {
        allAttempts = attempts

        updateCollection()
        
        if allAttempts.completedToday.count == 0 && allAttempts.dueSoon.count == 0 && allAttempts.failed.count == 0 && allAttempts.completed.count == 0 {
            addNoAttemptsEmptyState()
        } else {
            emptyStatePresenter.removeEmptyState(from: contentView)
        }
    }
    
    private func addNoAttemptsEmptyState() {
        let noAttemptsAttributes = PresenterAttributes(image: #imageLiteral(resourceName: "iconLandscape").recolor(to: .textColor), title: "You don't have any active goals! Add some goals in the Topics section to get started!", buttonText: "Reload") // TODO: constants
        emptyStatePresenter.present(with: noAttemptsAttributes, on: contentView, with: self)
    }
    
    private func addErrorEmptyState() {
        let noAttemptsAttributes = PresenterAttributes(image: #imageLiteral(resourceName: "iconLandscape").recolor(to: .textColor), title: "Uh oh! Something went wrong", buttonText: "Try again") // TODO: constants
        emptyStatePresenter.present(with: noAttemptsAttributes, on: contentView, with: self)
    }
    
    private func addNoInternetEmptyState() {
        let noAttemptsAttributes = PresenterAttributes(image: #imageLiteral(resourceName: "iconError").recolor(to: .textColor), title: "Uh Oh! No connection", buttonText: "Reload") // TODO: constants
        emptyStatePresenter.present(with: noAttemptsAttributes, on: contentView, with: self)
    }
    
    private func updateCollection(reloadFirstCompleted: Bool = false) {
        adapter?.performUpdates(animated: true, completion: { [weak self] (_) in
            guard let self = self else { return }
            if reloadFirstCompleted {
                self.reloadFirstCompleted()
            }
        })
    }
    
    private func reloadFirstCompleted() {
        guard let firstCompleted = allAttempts.completedToday.first, let firstSection = adapter?.sectionController(for: firstCompleted) as? AllAttemptsSectionController else {
            print("FIRST SECTION NOT FOUND, EXPECTED TO FIND FIRST SECTION")
            return
        }
        
        firstSection.reloadSection()
    }
}

extension AllAttemptsViewController: ListAdapterDataSource, AllAttemptsSectionControllerDelegate {
    func didSelect(_ attempt: Attempt) {
        let isAlreadyCompleted = allAttempts.completedToday.filter({ $0.id == attempt.id }).first != nil
        let goalIsInDueSoon = allAttempts.dueSoon.filter({ attempt.id == $0.id }).first != nil
        guard !isAlreadyCompleted, goalIsInDueSoon else {
            presentAttemptCompletedToday()
            return
        }
        
        presentCompleteActionSheet(for: attempt)
    }
    
    private func presentAttemptCompletedToday() {
        // TODO: show that it's already been completed
    }
    
    private func presentCompleteActionSheet(for attempt: Attempt) {
        let presenter = CompleteAttemptPresenter()
        presenter.present(with: self, { [weak self] in
            self?.completeDaily(attempt)
        })
    }
    
    private func completeDaily(_ attempt: Attempt) {
        goalService.postUserAttemptEntry(withIDOf: attempt.id, completedToday: true) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let attempt):
                self.allAttempts.dueSoon = self.allAttempts.dueSoon.filter({ $0.id != attempt.id })
                self.handleCompleted(attempt)
                // TODO: alert for completed
            case .failure(let error):
                self.handleGeneric(error)
            }
        }
    }
    
    private func handleCompleted(_ attempt: Attempt) {
        let reloadForFirstCompleted = self.allAttempts.completedToday.count == 0
        allAttempts.completedToday.append(attempt)
        
        updateCollection(reloadFirstCompleted: reloadForFirstCompleted)
        
        if attempt.completed {
            createBanner(with: "Congratulations! You completed a goal.").show()
        } else {
            createBanner(with: "Great work! Keep it up!").show()
        }
    }
    
    func shouldShowHeader(for attempt: Attempt) -> Bool {
        if let firstCompleted = allAttempts.completedToday.first, firstCompleted.id == attempt.id {
            return true
        } else if let firstNeedsCompletedToday = allAttempts.dueSoon.first, firstNeedsCompletedToday.id == attempt.id {
            return true
        } else if let firstCompleted = allAttempts.completed.first, firstCompleted.id == attempt.id {
            return true
        } else if let firstFailed = allAttempts.failed.first, firstFailed.id == attempt.id {
            return true
        } else {
            return false
        }
    }
    
    func getHeaderText(for attempt: Attempt) -> String {
        if let firstCompleted = allAttempts.completedToday.first, firstCompleted.id == attempt.id {
            return "Completed today" // TODO: constants
        } else if let firstFailed = allAttempts.failed.first, firstFailed.id == attempt.id {
            return "Failed"
        } else if let firstCompleted = allAttempts.completed.first, firstCompleted.id == attempt.id {
            return "Completed"
        } else {
            return "Due by end of day" // TODO: constants
        }
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return allAttempts.completedToday + allAttempts.dueSoon + allAttempts.failed + allAttempts.completed
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return AllAttemptsSectionController(withDelegate: self)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    private func subscribeForUpdateAttempts() {
        NotificationCenter.default.addObserver(self, selector: #selector(shouldUpdateAttempts), name: .reloadActiveAttempts, object: nil)
    }
    
    @objc func shouldUpdateAttempts() {
        loadAttempts()
    }
}

extension AllAttemptsViewController: EmptyStateViewDelegate {
    func didPressButton() {
        loadAttempts()
    }
}
