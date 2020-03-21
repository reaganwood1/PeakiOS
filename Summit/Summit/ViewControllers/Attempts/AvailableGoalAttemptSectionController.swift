//
//  AvailableGoalAttemptSectionController.swift
//  Summit
//
//  Created by Reagan Wood on 3/21/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import IGListKit

class AvailableGoalAttemptSectionController: ListSectionController {
    private var goal: MockAttempt? = nil
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow = 2
    
    override func numberOfItems() -> Int {
        return 20
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: AttemptCollectionViewCell = collectionContext?.dequeueReusableCell(of: AttemptCollectionViewCell.self, for: self, at: index) as? AttemptCollectionViewCell else {
            return AttemptCollectionViewCell()
        }
        guard let goal = goal else { return cell }
        
        cell.set(titleTo: goal.title, andSubtitleTo: "25 goals!")
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        super.didUpdate(to: object)
        if let object = object as? MockAttempt {
            goal = object
        }
    }
}
