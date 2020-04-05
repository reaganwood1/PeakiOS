//
//  TokenCache.swift
//  Summit
//
//  Created by Reagan Wood on 4/5/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import SwiftKeychainWrapper

public enum CachedToken {
    case facebookToken(String)
    case standard((PeakAccessToken, UserId))
}

public protocol ITokenCache: class {
    func getCachedLoginToken() -> (PeakAccessToken, UserId)?
    func getCachedSocialToken() -> String?
    func cacheToken(token: CachedToken)
    func invalidateUserCache()
}

public class TokenCache: ITokenCache {
    public init() {}
    
    public func getCachedSocialToken() -> String? {
        return KeychainWrapper.standard.string(forKey: Strings.Code.FacebookToken)
    }
    
    public func getCachedLoginToken() -> (PeakAccessToken, UserId)? {
        if let peakToken = KeychainWrapper.standard.string(forKey: Strings.Code.AccessToken), let userId = KeychainWrapper.standard.integer(forKey: Strings.Code.UserId) {
            return (peakToken, userId)
        } else {
            return nil
        }
    }
    
    public func cacheToken(token: CachedToken) {
        switch token {
        case .facebookToken(let token):
            KeychainWrapper.standard.set(token, forKey: Strings.Code.FacebookToken)
        case .standard(let peakAccessToken, let userId):
            KeychainWrapper.standard.set(peakAccessToken, forKey: Strings.Code.AccessToken)
            KeychainWrapper.standard.set(userId, forKey: Strings.Code.UserId)
        }
    }
    
    public func invalidateUserCache() {
        KeychainWrapper.standard.removeObject(forKey: Strings.Code.FacebookToken)
        KeychainWrapper.standard.removeObject(forKey: Strings.Code.AccessToken)
        KeychainWrapper.standard.removeObject(forKey: Strings.Code.UserId)
    }
}
