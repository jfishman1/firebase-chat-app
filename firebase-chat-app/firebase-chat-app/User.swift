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
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}
