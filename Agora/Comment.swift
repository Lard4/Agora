//
//  Comment.swift
//  Agora
//
//  Created by Varun Shenoy on 12/16/16.
//  Copyright © 2016 Varun Shenoy. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class Comment: NSObject {
    
    // comment attributes
    var comment = ""
    var timeStamp = ""
    var userID = ""
    var name = ""
    var pictureURL = ""
    var numericTimeStamp = 0.0
    
    // initialize a comment with raw data
    init(comment: String, userID: String, timeStamp: Double) {
        self.numericTimeStamp = timeStamp
        self.comment = comment
        self.userID = userID
        if (timeStamp == 0.0) {
            // if it's a brand new comment, show "now"
            self.timeStamp = "now"
        } else {
            // otherwise, format the time when the comment was posted
            let date = Date(timeIntervalSince1970: timeStamp)
            let df = DateFormatter()
            df.dateFormat = "MMM d, h:mm a"
            self.timeStamp = df.string(from: date)
        }
    }
    
    // get infomation about the commenter from Firebase
    func getUserInfo() {
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDict = snapshot.value as? [String : AnyObject] {
                self.name = userDict["name"] as! String
                self.pictureURL = userDict["image"] as! String
            }
        })
    }

}
