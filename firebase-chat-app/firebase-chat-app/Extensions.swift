//
//  Extensions.swift
//  firebase-chat-app
//
//  Created by Jonathon Fishman on 9/9/17.
//  Copyright © 2017 fatsjohonimahnn. All rights reserved.
//

import UIKit

// memory bank for all images being downloaded
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    // cacheing
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil // stops images from flashing and setting wrong image on the tableview
        
        // check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // otherwise fire a new download
        let url = URL(string: urlString)
        // execute this to download the image off of main queue
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if let error = error {
                print(error)
                return
            }
            //download is successful
            
            // we need to run image setter (all UI updates) on main queue
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)

                    self.image = downloadedImage
                }
            })
        }).resume() // needed to fire off URL session request
    }
}
