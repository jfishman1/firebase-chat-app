//
//  ChatMessageCell.swift
//  firebase-chat-app
//
//  Created by Jonathon Fishman on 9/15/17.
//  Copyright © 2017 fatsjohonimahnn. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {
    // UICollectionViewCells do not have default values like the TableView cells 
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Sample Text"
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textView)
        
        // constraints x, y, w, h
        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
