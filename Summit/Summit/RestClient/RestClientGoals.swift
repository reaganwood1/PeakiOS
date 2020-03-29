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
    
    public static func GetAllGoalChallenges(response: @escaping StandardRestResponse) {
        SessionManager.authorized.request(RestConstants.BaseURL + "challenges/", method: .get, parameters: nil).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
    
    public static func GetAvailableChallenges(for topic: Goal, response: @escaping StandardRestResponse) {
        SessionManager.authorized.request(RestConstants.BaseURL + "challenges/topic/\(topic.id)/", method: .get, parameters: nil).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
    
    public static func GetActiveUserAttempts(userID: Int, response: @escaping StandardRestResponse) {
        SessionManager.authorized.request(RestConstants.BaseURL + "user/\(userID)/attempts/", method: .get, parameters: nil).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
    
    public static func PostChallengeAttempt(challengeId: Int, response: @escaping StandardRestResponse) {
        SessionManager.authorized.request(RestConstants.BaseURL + "goal/attempt/\(challengeId)/", method: .post, parameters: nil).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
    
    public static func PostGoalEntry(completedInTimePeriod: Bool, attemptId: Int, response: @escaping StandardRestResponse) {
        let parameters = ["completed_in_time_period" : completedInTimePeriod] // TODO: constants
        SessionManager.authorized.request(RestConstants.BaseURL + "user/attempt/\(attemptId)/entry/", method: .post, parameters: parameters).responseJSON(completionHandler: RestClientGeneral.JsonResponseValidator(response: response))
    }
}
