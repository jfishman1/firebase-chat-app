//
//  Message.swift
//  firebase-chat-app
//
//  Created by Jonathon Fishman on 9/12/17.
//  Copyright © 2017 fatsjohonimahnn. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    
    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    var imageUrl: String?
    var videoUrl: String?
    var imageWidth: NSNumber?
    var imageHeight: NSNumber?
    
    init(messageDictionary: [String: Any]) {
        self.fromId = messageDictionary["fromId"] as? String
        self.text = messageDictionary["text"] as? String
        self.toId = messageDictionary["toId"] as? String
        self.timestamp = messageDictionary["timestamp"] as? NSNumber
        self.imageUrl = messageDictionary["imageUrl"] as? String
        self.videoUrl = messageDictionary["videoUrl"] as? String
        self.imageWidth = messageDictionary["imageWidth"] as? NSNumber
        self.imageHeight = messageDictionary["imageHeight"] as? NSNumber
    }
    
    func chatPartnerId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
        // same above and below
//        if fromId == FIRAuth.auth()?.currentUser?.uid {
//            return toId
//        } else {
//            return fromId
//        }
    }

}
