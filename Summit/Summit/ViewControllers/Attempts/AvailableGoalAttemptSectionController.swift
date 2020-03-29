//
//  AvailableGoalAttemptSectionController.swift
//  Summit
//
//  Created by Reagan Wood on 3/21/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import IGListKit

protocol AvailableGoalChallengeDelegate: class {
    func didSelect(_ challengeId: Int)
}

class AvailableGoalAttemptSectionController: ListSectionController {
    private var challenges: CollectionChallenges? = nil
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow = 2
    
    weak private var delegate: AvailableGoalChallengeDelegate?
    
    init(with delegate: AvailableGoalChallengeDelegate) {
        self.delegate = delegate
    }
    
    override func numberOfItems() -> Int {
        return challenges?.goalChallenges.count ?? 0
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: AttemptCollectionViewCell = collectionContext?.dequeueReusableCell(of: AttemptCollectionViewCell.self, for: self, at: index) as? AttemptCollectionViewCell else {
            return AttemptCollectionViewCell()
        }
        guard let challenges = challenges else { return cell }
        
        
        let challenge = challenges.goalChallenges[index]
        cell.set(difficultyTo: challenge.difficulty.rawValue, andSubtitleTo: challenge.title, challengeId: challenge.id, and: delegate, andTextColorOf: challenge.difficulty.color)
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        super.didUpdate(to: object)
        if let object = object as? CollectionChallenges {
            challenges = object
        }
    }
}

// SOURCE: https://github.com/MagicLab-team/PinterestLayout
extension AvailableGoalAttemptSectionController: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        guard let cell = cellForItem(at: indexPath.row) as? AttemptCollectionViewCell else { return 0.0 }
        return cell.getHeightForCell(withWidthOf: (UIScreen.main.bounds.width / 2) - 20) // TODO: calculate in a better way
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        return 0
    }
}
