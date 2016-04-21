//
//  Utils.swift
//  CustomFit
//
//  Created by Farwa Naqi on 4/9/16.
//  Copyright © 2016 Farwa Naqi. All rights reserved.
//

import UIKit
import Locksmith

class AuthUtils {
    static let AccessTokenKey = "FitChat-FitbitAccessToken"
    static let CurrentUserKey = "FitChat-CurrentUser"
    
    static func generateAccessTokenFromString(string: String?) -> AccessToken? {
        guard let fragment = string else {
            return nil
        }
        
        let components = NSURLComponents()
        components.query = fragment
        
        guard let userID = components.getQueryItem(Token.UserID)?.value,
            let scopes = components.getQueryItem(Token.Scopes)?.value,
            let tokenString = components.getQueryItem(Token.TokenString)?.value,
            let expiresInString = components.getQueryItem(Token.ExpiresIn)?.value,
            let expiresIn = Int(expiresInString) else {
            return nil
        }
        
        let accessToken = AccessToken(userID: userID, tokenString: tokenString, expiresIn: expiresIn, scopes: scopes.componentsSeparatedByString("+"))
        
        return accessToken
    }
    
    static func getAccessToken() -> AccessToken? {
        if let userID = NSUserDefaults.standardUserDefaults().stringForKey(CurrentUserKey) {
            let data = Locksmith.loadDataForUserAccount(userID)
            if let data = data, let accessToken = data[AccessTokenKey] as? AccessToken {
                return accessToken
            }
        }
        
        return nil
    }
    
    static func saveAccessToken(accessToken: AccessToken) -> Bool {
        NSUserDefaults.standardUserDefaults().setObject(accessToken.userID, forKey: CurrentUserKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        do {
            try Locksmith.saveData([AccessTokenKey: accessToken], forUserAccount: accessToken.userID)
            return true
        } catch {
            return false
        }
    }
}
