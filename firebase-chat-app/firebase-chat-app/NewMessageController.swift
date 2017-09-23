//
//  NewMessageControllerTableViewController.swift
//  firebase-chat-app
//
//  Created by Jonathon Fishman on 9/5/17.
//  Copyright © 2017 fatsjohonimahnn. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    let cellId = "cellId"
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : AnyObject] {
                let user = User(userDictionary: dictionary)
                user.id = snapshot.key // Firebase UUID
                self.users.append(user)

                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // hack to get setup without dequeue
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
//        cell.imageView?.image = UIImage(named:"nedstark")
//        cell.imageView?.contentMode = .scaleAspectFill
        
        // add images of each user to their cell
        if let profileImageUrl = user.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
    // moved below to extensions.swift
//            let url = URL(string: profileImageUrl)
//            // execute this to download the image off of main queue
//            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//                
//                //download hit an error so lets return out
//                if let error = error {
//                    print(error)
//                    return
//                }
//                //download is successful
//                
//                // we need to run image setter (all UI updates) on main queue
//                DispatchQueue.main.async(execute: {
//                    if let downloadedImage = UIImage(data: data!) {
////                        cell.imageView?.image = downloadedImage
//                        cell.profileImageView.image = downloadedImage
//                    }
//                })
//            }).resume() // needed to fire off URL session request
        }
        
        return cell
    }
    
    // add spacing to cells
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    var messagesController: MessagesController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: {
            print("dismiss completed")
            let user = self.users[indexPath.row]
            self.messagesController?.showChatControllerForUser(user: user)
            // messagesController will be nil bc we did not set it to any object yet,
            // we want to set messagesController every time we click the new chat button
            // when we click the new chat button aka rightBarButton "new_message_icon" we call handleNewMessage
        
        })
    }

}

