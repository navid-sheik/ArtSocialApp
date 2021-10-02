//
//  ProfileViewModel.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 27/09/2021.
//

import Foundation
import UIKit

class ProfileViewModel {
    var user : User
    
    var userName : String{
        return user.userName
    }
    
    var email : String{
        return user.email
    }
    
    
    var fullName : String{
        return user.fullName
    }
    
    
    var typeUserImageBtn : String{
        if user.isCurrentUser{
            return "pencil.circle"
        }
        return user.isFollowed ? "person.crop.circle.badge.minus" : "person.crop.circle.badge.plus"
    }
    
    
    var userFollowers  : NSMutableAttributedString{
        return createCustomString(user.userStats.followers, "Follower")
    }
    
    var userFollowing : NSMutableAttributedString {
        return createCustomString(user.userStats.following, "Following")
    }
    
    var userBuyers : NSMutableAttributedString{
        return createCustomString(0, "Buyers")
    }
    
    
    var butttonProfileText  : String {
        if user.isCurrentUser{
            return "UPLOAD"
        }
        return "MESSAGE"
    }
    
    init(user : User) {
        self.user = user
    }
    
    
    //MARK: HELPER FUNCTION
    private func createCustomString (_ number : Int, _ label : String ) -> NSMutableAttributedString{
        let mainString =  NSMutableAttributedString(string: "\(number)\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        mainString.append(NSAttributedString(string: "\(label)", attributes:  [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        return mainString
        
    }
    
}
