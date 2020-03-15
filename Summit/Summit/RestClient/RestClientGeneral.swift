//
//  RestClientGeneral.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Foundation
import Alamofire

public struct RestClientGeneral {
    public static func JsonResponseValidator(response: @escaping StandardRestResponse) -> (AFDataResponse<Any>) -> Void {
        let afResponse: (AFDataResponse<Any>) -> Void = {
            alamofireResponse in
            let statusCode = alamofireResponse.response?.statusCode ?? -1
            
            guard let data = alamofireResponse.value as? Data else {
                print("NO DATA RETURNED")
                response(false, statusCode, nil)
                return
            }
            
            let json = JsonFactory.convertToJSON(from: data)
            
            print(String(describing: alamofireResponse.request?.url))
            print(statusCode)
            
            if statusCode >= RestConstants.StatusCode.OK && statusCode < 300 {
                response(true, statusCode, json)
            } else if let error = alamofireResponse.error {
                print("STATUS CODE: \(statusCode)")
                print(String(describing: error))
                print("THE REQUEST FAILED with ALOFIRE ERROR")
                response(false, statusCode, json)
            } else {
                response(false, statusCode, json)
            }
        }
        
        return afResponse
    }
}
