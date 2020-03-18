//
//  Goal.swift
//  Summit
//
//  Created by Reagan Wood on 3/15/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

struct Goal: Codable {
    public enum CodingKeys: String, CodingKey {
        case title
        case pk
    }
    
    public let title: String
    public let pk: Int
}

struct BaseObject: Codable {
    
}
