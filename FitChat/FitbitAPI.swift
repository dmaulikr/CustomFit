//
//  FitbitAPI.swift
//  FitChat
//
//  Created by Farwa Naqi on 2015-09-30.
//  Copyright © 2015 Farwa Naqi. All rights reserved.
//

import Foundation
import AFNetworking

struct Get {
    static let Friends = "https://api.fitbit.com/1/user/%@/friends.json"
    static let FriendsLeaderboard = "https://api.fitbit.com/1/user/%@/friends/leaderboard.json"
    static let FriendInvitations = "https://api.fitbit.com/1/user/%@/friends/invitations.json";
    static let Badges = "https://api.fitbit.com/1/user/%@/badges.json"
    static let Profile = "https://api.fitbit.com/1/user/-/profile.json"
}

struct Post {
    static let InviteFriend = "https://api.fitbit.com/1/user/-/friends/invitations.json"
    static let RespondToFriendInvite = "https://api.fitbit.com/1/user/-/friends/invitations/%@.json";
}

struct RequestManager {
    static let manager = AFHTTPRequestOperationManager();
    static let authToken:String = String(format: "Bearer %@", NSUserDefaults.standardUserDefaults().stringForKey(Constants.UserDefaultKey.AuthToken) as String!);
    
    // GET friends request
    static func getFriends(userId: String, parameters: AnyObject?, success: ((AFHTTPRequestOperation, AnyObject) -> Void)?, failure: ((AFHTTPRequestOperation, NSError) -> Void)?) {
        manager.requestSerializer.setValue(authToken, forHTTPHeaderField: "Authorization");
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type");
        manager.GET(String(format: Get.Friends, userId), parameters: parameters, success: success, failure: failure);
    }
    
    // GET user profile request
    static func getProfile(parameters: AnyObject?, success: ((AFHTTPRequestOperation, AnyObject) -> Void)?, failure: ((AFHTTPRequestOperation, NSError) -> Void)?) {
        manager.requestSerializer.setValue(authToken, forHTTPHeaderField: "Authorization");
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type");
        manager.GET(Get.Profile, parameters: parameters, success: success, failure: failure);
    }
}