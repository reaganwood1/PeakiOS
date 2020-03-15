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
}

public class LoginService: GenericService, ILoginService {
    public func userFrom(_ accessToken: String, for userID: String, completion: @escaping (Result<User, GenericServiceError>) -> Void) {
        RestClientLogin.LoginFromAccessToken(accessToken: accessToken, userID: userID) { [weak self] standardResponse in
            guard let self = self else { return }
            
            let error = self.validate(standardResponse)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
        }
    }
}
