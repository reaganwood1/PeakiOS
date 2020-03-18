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
    
    private static var authorizedSessionManager: Session = Session(configuration: .default, interceptor: AuthorizedRequestIntercepter())
    
    public static var unauthorized: Session {
        return unauthorizedSessionManager
    }
    
    public static var authorized: Session {
        get {
            return authorizedSessionManager
        }
    }
}

public class AuthorizedRequestIntercepter: RequestInterceptor {
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var adaptedRequest = urlRequest
        guard let token = User.user?.accessToken else {
            completion(.success(adaptedRequest))
            return
        }
        adaptedRequest.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        completion(.success(adaptedRequest))
    }
}
