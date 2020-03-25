//
//  CollectionChallenges.swift
//  Summit
//
//  Created by Reagan Wood on 3/24/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import IGListKit

class CollectionChallenges: ListDiffable {
    public var id: Int = 1
    public var goalChallenges = [Challenge]()
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if object is CollectionChallenges {
            return true
        } else {
            return false
        }
    }
}
