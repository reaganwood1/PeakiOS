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
        let parameters = [
            RestConstants.Parameters.Username: username,
            RestConstants.Parameters.Password: password
        ]
        
        SessionManager.unauthorized.request(RestConstants.BaseURL + "login/", method: .post, parameters: parameters).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
    
    public static func Signup(username: String, password: String, email: String, response: @escaping StandardRestResponse) {
        let parameters = [
            RestConstants.Parameters.Username: username,
            RestConstants.Parameters.Password: password,
            RestConstants.Parameters.Email: email
        ]
        
        SessionManager.unauthorized.request(RestConstants.BaseURL + "signup/", method: .post, parameters: parameters).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
    
    public static func Logout(response: @escaping StandardRestResponse) {
        SessionManager.authorized.request(RestConstants.BaseURL + "logout/", method: .post, parameters: nil).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
    
    public static func LoginFromAccessToken(accessToken: String, userID: UserId, response: @escaping StandardRestResponse) {
        let parameters: [String: Any] = [
            RestConstants.Parameters.AccessToken: accessToken,
            RestConstants.Parameters.UserId: userID
        ]
        
        SessionManager.unauthorized.request(RestConstants.BaseURL + "login/access-token", method: .post, parameters: parameters).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
    
    public static func LoginFromSocialAccessToken(accessToken: String, provider: SocialProviders, response: @escaping StandardRestResponse) {
        let parameters = [
            "provider": provider.rawValue,
            "access_token": accessToken
        ] // TODO: constants
        
        SessionManager.unauthorized.request(RestConstants.BaseURL + "oauth/login/", method: .post, parameters: parameters).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
}
