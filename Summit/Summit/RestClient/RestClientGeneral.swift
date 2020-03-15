//
//  RestClientGeneral.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Alamofire

public struct RestClientGeneral {
    public static func JsonResponseValidator(response: @escaping StandardRestResponse) -> (AFDataResponse<Any>) -> Void {
        let afResponse: (AFDataResponse<Any>) -> Void = {
            alamofireResponse in
            let statusCode = alamofireResponse.response?.statusCode ?? -1

            let json = alamofireResponse.value as? Json
            
            print(String(describing: alamofireResponse.request?.url))
            print(statusCode)
            
            if statusCode >= RestConstants.StatusCode.OK && statusCode < 300 {
                response(StandardRestResponseParams(success: true, statusCode: statusCode, json: json))
            } else if let error = alamofireResponse.error {
                print("STATUS CODE: \(statusCode)")
                print(String(describing: error))
                print("THE REQUEST FAILED with ALOFIRE ERROR")
                response(StandardRestResponseParams(success: false, statusCode: statusCode, json: json))
            } else {
                response(StandardRestResponseParams(success: false, statusCode: statusCode, json: json))
            }
        }
        
        return afResponse
    }
}
