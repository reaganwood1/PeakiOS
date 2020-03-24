//
//  Challenge.swift
//  Summit
//
//  Created by Reagan Wood on 3/22/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Foundation

public class Challenge: Codable {
    public let id: Int
    public let title: String
    public let attemptsToComplete: Int
    public let failureAmount: Int
    public let goal: Int
}
