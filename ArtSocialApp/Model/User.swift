//
//  User.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 27/09/2021.
//

import Foundation
import UIKit
import FirebaseAuth

struct User {
    var uid : String
    var fullName : String
    var email : String
    var userName : String
    
    var isFollowed : Bool = false
    var userStats : UserStats!
    var isCurrentUser : Bool { return  Auth.auth().currentUser?.uid == uid}
    
    
    
    init(dictnary : [String : Any]) {
        self.fullName = dictnary["fullName"] as? String ?? ""
        self.email = dictnary["email"] as? String  ?? ""
        self.userName = dictnary["userName"] as? String  ?? ""
        self.uid =  dictnary["uid"] as? String ?? ""
        
        self.userStats =  UserStats(followers: 0, following: 0)
    }
}
