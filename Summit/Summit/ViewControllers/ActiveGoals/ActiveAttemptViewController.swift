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
    
    private var emptyStatePresenter = EmptyStatePresenter()

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
        subscribeForUpdateAttempts()
        loadAttempts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeNavBack(to: "Active") // TODO: constants
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
                self.handleRetrieved(attempts)
            case .failure(_):
                self.addNoInternetEmptyState()
            }
        }
    }
    
    private func handleRetrieved(_ attempts: UserAttemptsResponse) {
        activeAttempts = attempts

        updateCollection()
        
        if activeAttempts.completedToday.count == 0 && activeAttempts.dueSoon.count == 0 {
            addErrorEmptyState()
        } else {
            emptyStatePresenter.removeEmptyState(from: contentView)
        }
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
        guard let firstCompleted = activeAttempts.completedToday.first, let firstSection = adapter?.sectionController(for: firstCompleted) as? ActiveAttemptsSectionController else {
            print("FIRST SECTION NOT FOUND, EXPECTED TO FIND FIRST SECTION")
            return
        }
        
        firstSection.reloadSection()
    }
}

extension ActiveAttemptsViewController: ListAdapterDataSource, ActivateAttemptsSectionControllerDelegate {
    func didSelect(_ attempt: Attempt) {
        let isAlreadyCompleted = activeAttempts.completedToday.filter({ $0.id == attempt.id }).first != nil
        guard !isAlreadyCompleted else {
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
                self.activeAttempts.dueSoon = self.activeAttempts.dueSoon.filter({ $0.id != attempt.id })
                self.handleCompleted(attempt)
                // TODO: alert for completed
            case .failure(let error):
                break // TODO: complete error
            }
        }
    }
    
    private func handleCompleted(_ attempt: Attempt) {
        let reloadForFirstCompleted = self.activeAttempts.completedToday.count == 0
        activeAttempts.completedToday.append(attempt)
        
        updateCollection(reloadFirstCompleted: reloadForFirstCompleted)
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
            return "Due by end of day" // TODO: constants
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
    
    private func subscribeForUpdateAttempts() {
        NotificationCenter.default.addObserver(self, selector: #selector(shouldUpdateAttempts), name: .reloadActiveAttempts, object: nil)
    }
    
    @objc func shouldUpdateAttempts() {
        loadAttempts()
    }
}

extension ActiveAttemptsViewController: EmptyStateViewDelegate {
    func didPressButton() {
        loadAttempts()
    }
}
