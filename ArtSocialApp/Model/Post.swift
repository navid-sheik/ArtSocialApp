//
//  Posr.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 01/10/2021.
//

import Foundation
import  UIKit
import Firebase

struct Post{
    var postId : String
    var imageUrl : String
    var userId : String
    var likes : Int
    var commments : Int
    var timestamp : Timestamp
    var caption : String
    var username : String
    
    init(postId : String,  dictonary  :  [String : Any]) {
        self.postId =  postId
        self.imageUrl = dictonary["imageUrl"] as? String ?? ""
        self.userId = dictonary["userId"] as? String ?? ""
        self.likes = dictonary["likes"] as? Int ?? 0
        self.commments = dictonary["commments"] as? Int ?? 0
        self.caption = dictonary["caption"] as? String ?? ""
        self.timestamp =  dictonary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.username = dictonary["username"] as? String ?? ""
    }
    
}
