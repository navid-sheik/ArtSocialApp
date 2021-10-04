//
//  Commeny.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 03/10/2021.
//

import Foundation
import UIKit
import Firebase

struct Comment{
  
    var timestamp : Timestamp
    var userId: String
    var username : String
    var comment : String
    
    init( dict : [String : Any]) {

        self.timestamp =  dict["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.userId =  dict["userId"] as? String ?? ""
        self.username =  dict["username"] as? String ?? ""
        self.comment =  dict["comment"] as? String ?? ""
        
        
    }
    
}
