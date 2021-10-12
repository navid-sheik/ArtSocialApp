//
//  Notification.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 12/10/2021.
//

import Foundation
import UIKit
import Firebase

struct Notification {
    let id : String
    let fromUsername : String
    let postId : String?
    let postUrl : String?
    let type : NotificationType
    let timestamp : Timestamp

    
    
    init(dict : [String : Any]) {
        self.id =  dict["id"] as? String ?? ""
        self.fromUsername  = dict["fromUsername"] as? String ?? ""
        self.postId = dict["postId"] as? String
        self.postUrl =  dict["postUrl"] as? String
        self.type =  dict["type"] as? NotificationType ?? NotificationType.like
        self.timestamp =  dict["timestamp"] as? Timestamp ??  Timestamp(date: Date())
        
    }
    
}
