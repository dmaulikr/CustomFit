//
//  FitbitAPIManager.swift
//  CustomFit
//
//  Created by Farwa Naqi on 2015-09-30.
//  Copyright © 2015 Farwa Naqi. All rights reserved.
//

import Foundation
import Alamofire

class FitbitAPIManager {
    static let baseURL: String = "https://api.fitbit.com"
    
    static func buildRequest(path: String, method: Alamofire.Method) -> NSMutableURLRequest {
        let URL = NSURL(string: FitbitAPIManager.baseURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let accessToken = AuthUtils.getAccessToken() {
            mutableURLRequest.setValue("Bearer \(accessToken.tokenString)", forHTTPHeaderField: "Authorization")
        }
        
        return mutableURLRequest
    }
    
    static func getLoginURL() -> NSURL {
        let scopes = [Scopes.Activity, Scopes.Profile, Scopes.Social]
        
        let components = NSURLComponents(string: "https://www.fitbit.com/oauth2/authorize")!
        var queryItems = [NSURLQueryItem]()
        queryItems.append(NSURLQueryItem(name: Login.ClientID, value: App.AppID))
        queryItems.append(NSURLQueryItem(name: Login.ResponseType, value: OAuth.Token))
        queryItems.append(NSURLQueryItem(name: Login.Scope, value: scopes.joinWithSeparator(" ")))
        queryItems.append(NSURLQueryItem(name: Login.RedirectURI, value: App.Callback))
        queryItems.append(NSURLQueryItem(name: Login.ExpiresIn, value: Expires.Month))
        components.queryItems = queryItems
        
        return components.URL!
    }
}

enum UserRouter: URLRequestConvertible {
    case Profile(String)
    case Badges(String)
    case Update(String)
    
    var method: Alamofire.Method {
        switch self {
        case Profile:
            return .GET
        case Badges:
            return .GET
        case Update:
            return .POST
        }
    }
    
    var path: String {
        switch self {
        case Profile(let userID):
            return "1/user/\(userID)/profile.json"
        case Badges(let userID):
            return "1/user/\(userID)/badges.json"
        case Update(let userID):
            return "1/user/\(userID)/profile.json"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        return FitbitAPIManager.buildRequest(path, method: method)
    }
}

enum FriendsRouter: URLRequestConvertible {
    case All(String)
    case Leaderboard(String)
    
    var method: Alamofire.Method {
        return .GET
    }
    
    var path: String {
        switch self {
        case All(let userID):
            return "1/user/\(userID)/friends"
        case Leaderboard(let userID):
            return "1/user/\(userID)/friends/leaderboard.json"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        return FitbitAPIManager.buildRequest(path, method: method)
    }
}
