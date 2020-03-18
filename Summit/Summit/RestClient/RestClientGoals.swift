//
//  RestClientGoals.swift
//  Summit
//
//  Created by Reagan Wood on 3/17/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Alamofire

public struct RestClientGoals {
    public static func GetAllGoals(response: @escaping StandardRestResponse) {
        SessionManager.authorized.request(RestConstants.BaseURL + "goals/", method: .get, parameters: nil).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
}
