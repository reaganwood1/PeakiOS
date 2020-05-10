//
//  RestConstants.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//


public class SummitEnvironment {
    public static var IsProduction: Bool {
        #if PRODUCTION
            return true
        #else
            return false
        #endif
    }
}

public struct RestConstants {
    public static var BaseURL: String {
        get {
            if SummitEnvironment.IsProduction {
                return "https://www.reagankwood.com/peakapi/"
            } else {
                return "http://127.0.0.1:8000/"
            }
        }
    }
    
    public struct Parameters {
        public static var AccessToken = "access_token"
        public static var UserId = "user_id"
        public static var Username = "user_name"
        public static var Password = "password"
        public static var User = "user"
        public static var Token = "token"
    }
    
    public struct StatusCode {
        public static var OK = 200
        public static var NoNetwork = -1
        public static var BadRequest = 400
        public static var ServerError = 500
    }
}
