//
//  LoginService.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Foundation

public protocol ILoginService: class {
    func userFrom(_ accessToken: String, for userID: String, completion: @escaping (Result<User, GenericServiceError>) -> Void)
    func login(username: String, password: String, completion: @escaping (Result<User, GenericServiceError>) -> Void)
}

public class LoginService: GenericService, ILoginService {
    private let responseFactory: ResponseFactory
    
    init(responseFactory: ResponseFactory = ResponseFactory()) {
        self.responseFactory = responseFactory
    }
    
    public func userFrom(_ accessToken: String, for userID: String, completion: @escaping (Result<User, GenericServiceError>) -> Void) {
        RestClientLogin.LoginFromAccessToken(accessToken: accessToken, userID: userID) { [weak self] standardRestResponse in
            guard let self = self else { return }
            
            let error = self.validate(standardRestResponse)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            self.parseUser(from: standardRestResponse, completion: completion)
        }
    }
    
    public func login(username: String, password: String, completion: @escaping (Result<User, GenericServiceError>) -> Void) {
        RestClientLogin.Login(username: username, password: password) { [weak self] (standardRestResponse) in
            guard let self = self else { return }
            
            let error = self.validate(standardRestResponse)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            self.parseUser(from: standardRestResponse, completion: completion)
        }
    }
    
    private func parseUser(from standardRestResponse: StandardRestResponseParams, completion: @escaping (Result<User, GenericServiceError>) -> Void) {
        guard let json = standardRestResponse.json else {
            print("JSON NOT RETURNED")
            completion(.failure(.serverError))
            return
        }
        
        guard let user = responseFactory.parse(json[RestConstants.Parameters.User] as? Json ?? [:], to: User.self, parseWithSnakeCase: true), let token = json[RestConstants.Parameters.Token] as? String else {
            print("Could not parse the user from the response")
            completion(.failure(.serverError))
            return
        }
        
        user.accessToken = token
        User.SetInstance(user: user)
        completion(.success(user))
    }
}
