//
//  User.swift
//  firebase-chat-app
//
//  Created by Jonathon Fishman on 9/6/17.
//  Copyright © 2017 fatsjohonimahnn. All rights reserved.
//

import UIKit


class User: NSObject {
    var id: String?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    
    init(userDictionary: [String: AnyObject]) {
        self.id = userDictionary["id"] as? String
        self.name = userDictionary["name"] as? String
        self.email = userDictionary["email"] as? String
        self.profileImageUrl = userDictionary["profileImageUrl"] as? String
    }
}
