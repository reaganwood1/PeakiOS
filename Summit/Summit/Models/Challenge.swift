//
//  Challenge.swift
//  Summit
//
//  Created by Reagan Wood on 3/22/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

public class Challenge: Codable {
    public let id: Int
    public let title: String
    public let attemptsToComplete: Int
    public let failureAmount: Int
    public let goal: Int
    public let difficulty: Difficulty
    public var added: Bool? = false
}

public enum Difficulty: String, Codable {
    case easy = "EASY"
    case medium = "MEDIUM"
    case hard = "HARD"
    
    var color: UIColor {
        switch self {
        case .easy:
            return .summitBlue
        case .medium:
            return .summitGreen
        case .hard:
            return .summitPurple
        }
    }
}
