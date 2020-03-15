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

//public typealias StandardRestResponseParams = (Success, StatusCode, Json?)
public struct StandardRestResponseParams {
    public var success: Bool
    public var statusCode: Int
    public var json: Json?
}

public typealias StandardRestResponse = (StandardRestResponseParams) -> Void

public struct RestClientLogin {
    public static func Login(username: String, password: String, response: @escaping StandardRestResponse) {
        SessionManager.unauthorized.request(RestConstants.BaseURL, method: .post, parameters: nil).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response)) // TODO: finish
    }
    
    public static func LoginFromAccessToken(accessToken: String, userID: String, response: @escaping StandardRestResponse) {
        let parameters = [
            RestConstants.Parameters.Token: accessToken,
            RestConstants.Parameters.UserId: userID
        ]
        
        SessionManager.unauthorized.request(RestConstants.BaseURL + "login/access-token", method: .post, parameters: parameters).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response)) // TODO: finish
    }
}
