//
//  User.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Foundation

public class User: Codable {
    public private(set) static var user: User?
//    public enum CodingKeys: String, CodingKey {
//        case id
//        case lastLogin
//        case username
//        case firstName
//        case lastName
//        case email
//    }
    
    public let id: Int
    public let lastLogin: String
    public let username: String
    public let firstName: String
    public let lastName: String
    public let email: String
    public var accessToken: String?
    
    public static func SetInstance(user: User) {
        User.user = user
    }
}
