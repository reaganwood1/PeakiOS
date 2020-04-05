//
//  LoginService.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit

public enum SocialProviders: String {
    case facebook = "facebook"
}

public protocol ILoginService: class {
    func userFrom(_ accessToken: String, for userID: UserId, completion: @escaping (Result<User, GenericServiceError>) -> Void)
    func login(username: String, password: String, completion: @escaping (Result<User, GenericServiceError>) -> Void)
    func socialUserFrom(_ accessToken: String, provider: SocialProviders, completion: @escaping (Result<User, GenericServiceError>) -> Void)
    func logout(completion: @escaping (Result<Void, GenericServiceError>) -> Void)
}

public class LoginService: GenericService, ILoginService {
    private let responseFactory: ResponseFactory
    private let tokenCache: ITokenCache
    
    init(responseFactory: ResponseFactory = ResponseFactory(), tokenCache: ITokenCache = TokenCache()) {
        self.tokenCache = tokenCache
        self.responseFactory = responseFactory
    }
    
    public func logout(completion: @escaping (Result<Void, GenericServiceError>) -> Void) {
        if let socialCache = tokenCache.getCachedSocialToken() {
            LoginManager().logOut()
        }
        tokenCache.invalidateUserCache()
        
        // TODO: implement logout
    }
    
    public func socialUserFrom(_ accessToken: String, provider: SocialProviders, completion: @escaping (Result<User, GenericServiceError>) -> Void) {
        RestClientLogin.LoginFromSocialAccessToken(accessToken: accessToken, provider: provider) { [weak self] (standardRestResponse) in // TODO: constants
            guard let self = self else { return }
            
            let error = self.validate(standardRestResponse)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            self.parseUser(from: standardRestResponse, completion: completion)
        }
    }
    
    public func userFrom(_ accessToken: String, for userID: UserId, completion: @escaping (Result<User, GenericServiceError>) -> Void) {
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
        
        tokenCache.cacheToken(token: .standard((token, user.id)))
        user.accessToken = token
        User.SetInstance(user: user)
        completion(.success(user))
    }
}
