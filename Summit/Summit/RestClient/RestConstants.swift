//
//  RestConstants.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//


public class SummitEnvironment {
    public static var IsProduction: Bool = false
    
    public static func SetEnvironment(isProd: Bool) {
        IsProduction = isProd
    }
}

public struct RestConstants {
    public static var BaseURL: String {
        get {
            if SummitEnvironment.IsProduction {
                return "TODO: implement prod url"
            } else {
                return "http://127.0.0.1:8000/"
            }
        }
    }
    
    public struct StatusCode {
        public static var OK = 200
        public static var NoNetwork = -1
        public static var BadRequest = 400
        public static var ServerError = 500
    }
}
