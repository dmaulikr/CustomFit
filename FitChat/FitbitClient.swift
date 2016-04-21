//
//  FitbitClient.swift
//  CustomFit
//
//  Created by Farwa Naqi on 4/9/16.
//  Copyright © 2016 Farwa Naqi. All rights reserved.
//

import SwiftyJSON
import Alamofire

public class FitbitClient {
    
    static let sharedInstance = FitbitClient()
    
    /**
     Returns a user's profile. The authenticated owner receives all values.
     
     - parameter userID:     the encoded ID of the user. Defaults to "-" for current user
     - parameter completion: completion handler that has the parsed UserProfile from response
     */
    public func getUserProfile(userID: String = "-", completion:(profile: UserProfile?, error: FitbitError?) -> (Void)) {
        Alamofire.request(UserRouter.Profile(userID)).responseJSON {
            response in
            var userProfile: UserProfile?
            switch response.result {
            case .Success(let json):
                let errorType = JSON(json)["errors"][0]["errorType"]
                if let error = errorType.string {
                    completion(profile: nil, error: FitbitError(rawValue: error))
                    return
                }
                userProfile = UserProfile(data: JSON(json)["user"])
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
            
            completion(profile: userProfile, error: nil)
        }
    }
}
