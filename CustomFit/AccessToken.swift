//
//  AccessToken.swift
//  CustomFit
//
//  Created by Farwa Naqi on 4/9/16.
//  Copyright © 2016 Farwa Naqi. All rights reserved.
//

import UIKit

class AccessToken: NSObject, NSCoding {
    var expiresIn: Int
    var scopes: [String]
    var tokenString: String
    var userID: String
    
    init(userID: String, tokenString: String, expiresIn: Int, scopes: [String]) {
        self.expiresIn = expiresIn
        self.scopes = scopes
        self.tokenString = tokenString
        self.userID = userID
        
        super.init()
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let scopes = decoder.decodeObjectForKey(Token.Scopes) as? [String],
            let tokenString = decoder.decodeObjectForKey(Token.TokenString) as? String,
            let userID = decoder.decodeObjectForKey(Token.UserID) as? String else {
                return nil
        }
        
        self.init(userID: userID,
                  tokenString: tokenString,
                  expiresIn: decoder.decodeIntegerForKey(Token.ExpiresIn),
                  scopes: scopes)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInt(Int32(self.expiresIn), forKey: Token.ExpiresIn)
        coder.encodeObject(self.scopes, forKey: Token.Scopes)
        coder.encodeObject(self.tokenString, forKey: Token.TokenString)
        coder.encodeObject(self.userID, forKey: Token.UserID)
    }
}
