//
//  Constants.swift
//  CustomFit
//
//  Created by Farwa Naqi on 2015-09-29.
//  Copyright © 2015 Farwa Naqi. All rights reserved.
//

import Foundation

struct App {
    static let AppID = "229VK8"
    static let Callback = "fitchat://"
}

struct Expires {
    static let Day = "86400"
    static let Week = "604800"
    static let Month = "2592000"
}

struct Login {
    static let ClientID = "client_id"
    static let ExpiresIn = "expires_in"
    static let RedirectURI = "redirect_uri"
    static let ResponseType = "response_type"
    static let Scope = "scope"
}

struct OAuth {
    static let Code = "code"
    static let Token = "token"
}

struct Scopes {
    static let Activity = "activity"
    static let HeartRate = "heartrate"
    static let Location = "location"
    static let Nutrition = "nutrition"
    static let Profile = "profile"
    static let Settings = "settings"
    static let Sleep = "sleep"
    static let Social = "social"
    static let Weight = "weight"
}

struct Storyboard {
    static let Name = "Main"
    static let UserProfileViewController = "UserProfileViewController"
    static let TabBarController = "MainTabBarController"
}

struct Token {
    static let TokenString = "access_token"
    static let UserID = "user_id"
    static let Scopes = "scope"
    static let ExpiresIn = "expires_in"
}

struct Constants {
    struct NotificationKey {
        static let AuthenticationComplete = "kAuthenticationComplete"
    }
    
    struct UserDefaultKey {
        static let AuthToken = "kAuthToken"
    }
}
