//
//  SessionManager.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Alamofire

public class SessionManager {
    private static let unauthorizedSessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        let session = Session(configuration: configuration)
        return session
    }()
    
    public static var unauthorized: Session {
        get {
            return unauthorizedSessionManager
        }
    }
}
