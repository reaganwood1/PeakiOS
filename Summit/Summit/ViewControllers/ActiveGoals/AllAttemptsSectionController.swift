//
//  ActiveGoalsSectionController.swift
//  Summit
//
//  Created by Reagan Wood on 3/23/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import IGListKit

protocol AllAttemptsSectionControllerDelegate: class {
    func shouldShowHeader(for attempt: Attempt) -> Bool
    func getHeaderText(for attempt: Attempt) -> String
    func didSelect(_ attempt: Attempt)
}
class AllAttemptsSectionController: ListSectionController, ListSupplementaryViewSource {
    weak private var delegate: AllAttemptsSectionControllerDelegate?
    
    private var attempt: Attempt? = nil // TODO: get another type of item in here.
    
    private var offsetFromScreenEdges: CGFloat = 30.0
    private let headerHeight: CGFloat = 65.0
    
    init(withDelegate delegate: AllAttemptsSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
        self.inset = UIEdgeInsets(top: 0.0, left: 0, bottom: 20.0, right: 0.0)
        supplementaryViewSource = self
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let cell = cellForItem(at: index) as? UserAttemptCollectionViewCell else {
            return CGSize.zero
        }
        
        let cellWidth = getCellWidth()
        return CGSize(width: cellWidth, height: cell.getHeightForCell(withWidthOf: cellWidth))
    }
    
    private func getCellWidth() -> CGFloat {
        return UIScreen.main.bounds.width - offsetFromScreenEdges
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func didSelectItem(at index: Int) {
        guard let attempt = attempt else { return }
        delegate?.didSelect(attempt)
    }
    
    public func reloadSection() {
        collectionContext?.performBatch(animated: true, updates: { [weak self] (context) in
            guard let self = self else { return }
            context.reload(self)
        }, completion: nil)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: UserAttemptCollectionViewCell = collectionContext?.dequeueReusableCell(of: UserAttemptCollectionViewCell.self, for: self, at: index) as? UserAttemptCollectionViewCell else {
            return UserAttemptCollectionViewCell()
        }
        guard let attempt = attempt else { return cell }
        
        cell.set(attemptDescription: attempt.goalChallenge.title, andDifficultyTo: attempt.goalChallenge.difficulty.rawValue, currentCompleted: attempt.currentCompleted, goalY: attempt.goalChallenge.attemptsToComplete, currentY: attempt.currentCompleted, withCellWidth: getCellWidth(), difficultyColor: attempt.goalChallenge.difficulty.color)
        
        if attempt.goalChallenge.attemptsToComplete == 1 {
            cell.hideGraph()
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        super.didUpdate(to: object)
        if let object = object as? Attempt {
            attempt = object
        }
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: getCellWidth(), height: headerHeight)
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        guard let header = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: ActiveAttemptCollectionViewHeader.self, at: index) as? ActiveAttemptCollectionViewHeader else {
            fatalError()
        }
        guard let delegate = delegate, let attempt = attempt else { return header }
        let text = delegate.getHeaderText(for: attempt)
        header.headerText = text
        
        return header
    }
    
    func supportedElementKinds() -> [String] {
        guard let delegate = delegate, let attempt = attempt else { return [] }
        
        if delegate.shouldShowHeader(for: attempt) {
             return [UICollectionView.elementKindSectionHeader]
        } else {
            return []
        }
    }
}
