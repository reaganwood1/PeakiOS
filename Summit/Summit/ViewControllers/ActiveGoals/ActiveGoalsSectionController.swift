//
//  ActiveGoalsSectionController.swift
//  Summit
//
//  Created by Reagan Wood on 3/23/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import IGListKit

class ActiveAttemptsSectionController: ListSectionController {
    private var attempt: Attempt? = nil // TODO: get another type of item in here.
    
    private var offsetFromScreenEdges: CGFloat = 30.0
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 20.0, left: 0, bottom: 0.0, right: 0.0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let cell = cellForItem(at: index) as? ActiveGoalCollectionViewCell else {
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
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: ActiveGoalCollectionViewCell = collectionContext?.dequeueReusableCell(of: ActiveGoalCollectionViewCell.self, for: self, at: index) as? ActiveGoalCollectionViewCell else {
            return ActiveGoalCollectionViewCell()
        }
        guard let attempt = attempt else { return cell }
        
        cell.set(attemptDescription: attempt.goalChallenge.title, andDifficultyTo: "HARD", currentCompleted: attempt.currentCompleted, withCellWidth: getCellWidth())
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        super.didUpdate(to: object)
        if let object = object as? Attempt {
            attempt = object
        }
    }
}
