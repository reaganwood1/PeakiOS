//
//  RestClientLogin.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Alamofire

public typealias Json = [String : Any]
public typealias Success = Bool
public typealias StatusCode = Int

public typealias StandardRestResponse = (Success, StatusCode, Json?) -> Void

public struct RestClientLogin {
    public static func Login(username: String, password: String, response: @escaping StandardRestResponse) {
        Requester.unauthorized.request(RestConstants.BaseURL, method: .post, parameters: nil).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
}

public class Requester {
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
