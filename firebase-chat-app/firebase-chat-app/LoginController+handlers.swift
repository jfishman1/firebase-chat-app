//
//  LoginController+handlers.swift
//  firebase-chat-app
//
//  Created by Jonathon Fishman on 9/7/17.
//  Copyright © 2017 fatsjohonimahnn. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleRegister() {
        // call firebase authentication
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            // successfully authenticated user
            // create UUID for each image
            let imageName = NSUUID().uuidString
            // upload image to Firebase storage, the reference needs a name, use .jpg for compression help below
            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            // safely unwrap image and compress
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
            //compress image
            //if let uploadData = UIImageJPEGRepresentation(self.profileImageView.image!, 0.1) {
            
            // create binary data to upload into storage
            //if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    print(metadata!)

                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        
                        let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                        
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                    }
                })
            }
        })
    }
    // "fileprivate" access control keyword limits use of entities to the source in which it was defined and can be used in extensions of that source whereas "private" can only be accessed in the lexical scope it is declared and cannot be accessed in extensions with Swift 3
    fileprivate func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference()
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
            
 // unneccessary firebase call           self.messagesController?.fetchUserAndSetNavBarTitle()
//            self.messagesController?.navigationItem.title = values["name"] as? String
            let user = User()
            // this setter will potentially crash if keys don't match
            user.setValuesForKeys(values)
            self.messagesController?.setupNavBarWithUser(user: user)
            print("Saved user successfully to Firebase DB!!!!!!!!!!!!")
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func handleSelectedProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //print(info)
        // capture the selected image
        var selectedImageFromPicker: UIImage?
        // get the image from the picker
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        // unwrap image to access it
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
}
