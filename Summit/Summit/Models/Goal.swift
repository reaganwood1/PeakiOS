//
//  Goal.swift
//  Summit
//
//  Created by Reagan Wood on 3/15/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

class Goal: Codable {
    public enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    public let id: Int
    public let title: String
}
