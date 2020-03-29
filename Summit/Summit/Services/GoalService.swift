//
//  GoalService.swift
//  Summit
//
//  Created by Reagan Wood on 3/17/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

protocol IGoalService: class {
    func getGoals(completion: @escaping (Result<[Goal], GenericServiceError>) -> Void)
    func getActiveUserGoalAttemps(userID: Int, completion: @escaping (Result<UserAttemptsResponse, GenericServiceError>) -> Void)
    func getGoalChallenges(completion: @escaping (Result<[Challenge], GenericServiceError>) -> Void)
    func getAvailableChallenges(for topic: Goal, completion: @escaping (Result<[Challenge], GenericServiceError>) -> Void)
    func postGoalChallenge(withIDOf challengeId: Int, completion: @escaping (Result<Void, GenericServiceError>) -> Void)
    func postUserAttemptEntry(withIDOf attemptId: Int, completedToday: Bool, completion: @escaping (Result<Attempt, GenericServiceError>) -> Void)
}

public class UserAttemptsResponse: Codable {
    var dueSoon: [Attempt] = []
    var completedToday: [Attempt] = []
    
    convenience init(dueSoon: [Attempt] = [], completedToday: [Attempt] = []) {
        self.init()
        self.dueSoon = dueSoon
        self.completedToday = completedToday
    }
}

public class GoalService: GenericService, IGoalService {
    private let responseFactory: ResponseFactory
    
    init(with responseFactory: ResponseFactory = ResponseFactory()) {
        self.responseFactory = responseFactory
    }
    
    func getGoalChallenges(completion: @escaping (Result<[Challenge], GenericServiceError>) -> Void) {
        RestClientGoals.GetAllGoalChallenges { [weak self] (standardRestResponse) in
            guard let self = self else { return }
            let error = self.validate(standardRestResponse)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let json = standardRestResponse.json, let goalsJson = json["challenges"] as? [Json] else { // TODO: constants
                print("JSON :\(standardRestResponse.json ?? [:])")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            guard let challenges = self.responseFactory.parseObjectArray(from: goalsJson, to: [Challenge].self) else {
                print("JSON :\(json)")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            completion(.success(challenges))
        }
    }
    
    func getAvailableChallenges(for topic: Goal, completion: @escaping (Result<[Challenge], GenericServiceError>) -> Void) {
        RestClientGoals.GetAvailableChallenges(for: topic) { [weak self] (standardRestResponse) in
            guard let self = self else { return }
            let error = self.validate(standardRestResponse)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let json = standardRestResponse.json, let goalsJson = json["challenges"] as? [Json] else { // TODO: constants
                print("JSON :\(standardRestResponse.json ?? [:])")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            guard let challenges = self.responseFactory.parseObjectArray(from: goalsJson, to: [Challenge].self) else {
                print("JSON :\(json)")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            completion(.success(challenges))
        }
    }
    
    func getGoals(completion: @escaping (Result<[Goal], GenericServiceError>) -> Void) {
        RestClientGoals.GetAllGoals { [weak self] (standardRestResponse) in
            guard let self = self else { return }
            let error = self.validate(standardRestResponse)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let json = standardRestResponse.json, let goalsJson = json["goals"] as? [Json] else { // TODO: constants
                print("JSON :\(standardRestResponse.json ?? [:])")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            guard let goals = self.responseFactory.parseObjectArray(from: goalsJson, to: [Goal].self) else {
                print("JSON :\(json)")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            completion(.success(goals))
        }
    }
    
    public func getActiveUserGoalAttemps(userID: Int, completion: @escaping (Result<UserAttemptsResponse, GenericServiceError>) -> Void) {
        RestClientGoals.GetActiveUserAttempts(userID: userID) { [weak self] (standardRestResponse) in
            guard let self = self else { return }
            let error = self.validate(standardRestResponse)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let json = standardRestResponse.json else {
                print("JSON :\(standardRestResponse.json ?? [:])")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            guard let userAttempts = self.responseFactory.parse(json, to: UserAttemptsResponse.self) else {
                print("JSON :\(json)")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            completion(.success(userAttempts))
        }
    }
    
    public func postGoalChallenge(withIDOf challengeId: Int, completion: @escaping (Result<Void, GenericServiceError>) -> Void) {
        RestClientGoals.PostChallengeAttempt(challengeId: challengeId) { [weak self] (standardRestResponse) in
            guard let self = self else { return }
            let error = self.validate(standardRestResponse)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }
    }
    
    public func postUserAttemptEntry(withIDOf attemptId: Int, completedToday: Bool, completion: @escaping (Result<Attempt, GenericServiceError>) -> Void) {
        RestClientGoals.PostGoalEntry(completedInTimePeriod: completedToday, attemptId: attemptId) { [weak self] (standardRestResponse) in
            guard let self = self else { return }
            let error = self.validate(standardRestResponse)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let attemptJson = standardRestResponse.json?["attempt"] as? Json else {
                print("JSON :\(standardRestResponse.json ?? [:])")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            guard let attempt = self.responseFactory.parse(attemptJson, to: Attempt.self) else {
                print("JSON :\(attemptJson)")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            completion(.success(attempt))
        }
    }
}
