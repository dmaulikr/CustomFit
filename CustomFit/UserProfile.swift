//
//  UserProfile.swift
//  CustomFit
//
//  Created by Farwa Naqi on 4/9/16.
//  Copyright © 2016 Farwa Naqi. All rights reserved.
//

import SwiftyJSON

public class UserProfile {
    public var avatar: String?
    public var averageDailySteps: Int?
    public var fullName: String?

    init(data: JSON) {
        avatar = data["avatar"].string
        averageDailySteps = data["averageDailySteps"].int
        fullName = data["fullName"].string
    }
}
