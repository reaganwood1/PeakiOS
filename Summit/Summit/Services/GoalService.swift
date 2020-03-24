//
//  GoalService.swift
//  Summit
//
//  Created by Reagan Wood on 3/17/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

protocol IGoalService: class {
    func getGoals(completion: @escaping (Result<[Goal], GenericServiceError>) -> Void)
    func getActiveUserGoalAttemps(userID: Int, completion: @escaping (Result<[Attempt], GenericServiceError>) -> Void)
}
public class GoalService: GenericService, IGoalService {
    private let responseFactory: ResponseFactory
    
    init(with responseFactory: ResponseFactory = ResponseFactory()) {
        self.responseFactory = responseFactory
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
    
    public func getActiveUserGoalAttemps(userID: Int, completion: @escaping (Result<[Attempt], GenericServiceError>) -> Void) {
        RestClientGoals.GetActiveUserAttempts(userID: userID) { [weak self] (standardRestResponse) in
            guard let self = self else { return }
            let error = self.validate(standardRestResponse)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let json = standardRestResponse.json, let attemptsJson = json["attempts"] as? [Json] else { // TODO: constants
                print("JSON :\(standardRestResponse.json ?? [:])")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            guard let attempts = self.responseFactory.parseObjectArray(from: attemptsJson, to: [Attempt].self) else {
                print("JSON :\(json)")
                print("Unable to parse the response from the json")
                completion(.failure(.serverError))
                return
            }
            
            completion(.success(attempts))
        }
    }
}
