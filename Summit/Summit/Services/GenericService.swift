//
//  GenericService.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Foundation

public class GenericService {
    public func validate(_ standardResponse: StandardRestResponseParams, logJsonForFailure: Bool = true) -> GenericServiceError? {
        guard standardResponse.statusCode != RestConstants.StatusCode.NoNetwork else {
            print("no network connection")
            return .noNetwork
        }
        guard standardResponse.success else {
            print("STATUSCODE: \(standardResponse.statusCode)")
            print("ERROR \(String(describing: standardResponse.json))")
            return .serverError
        }
        
        return nil
    }
}
