//
//  Goal.swift
//  Summit
//
//  Created by Reagan Wood on 3/15/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import IGListKit

public class Goal: Codable, ListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? Goal {
            return object.id == id
        }
    
        return false
    }
    
    public enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    public let id: Int
    public let title: String
}
