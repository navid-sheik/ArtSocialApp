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
    let uid : String
    var isUserFollowed  = false

    
    
    init(dict : [String : Any]) {
        self.id =  dict["id"] as? String ?? ""
        self.uid  =  dict["uid"] as? String ?? ""
        self.fromUsername  = dict["fromUsername"] as? String ?? ""
        self.postId = dict["postId"] as? String
        self.postUrl =  dict["postUrl"] as? String
        self.type =  NotificationType(rawValue: dict["type"] as! Int)  ?? NotificationType.like
        self.timestamp =  dict["timestamp"] as? Timestamp ??  Timestamp(date: Date())
        
    }
    
}
