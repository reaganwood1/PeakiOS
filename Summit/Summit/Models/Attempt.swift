//
//  Attempt.swift
//  Summit
//
//  Created by Reagan Wood on 3/22/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Foundation
import IGListKit

public class Attempt: Codable, ListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? Attempt {
            return object.id == id
        }
        
        return false
    }
    
    public let id: Int
    public let currentCompleted: Int
    public let misessRemaining: Int
    public let completed: Bool
    public let goalChallenge: Challenge
}
