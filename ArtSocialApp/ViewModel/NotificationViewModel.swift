//
//  NotificationViewModel.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 13/10/2021.
//

import Foundation
import UIKit

class NotificationViewModel {
    var notification : Notification
    
    
    init(notification : Notification) {
        self.notification = notification
    }
    
    var postImage :  URL? {
        return URL(string: notification.postUrl ?? "")
        
    
    }
    
    var username : String {
        return notification.fromUsername
    }
    
    var notificationText : String{
        return notification.type.messageNotification
    }
    
    var isFollowType : Bool {
        return notification.type == .follow
    }
    
    
    var buttonText : String{
        return notification.isUserFollowed ? "Following" : "Follow"
    }
    
    var backgroundFollowBUtton  : UIColor {
        return notification.isUserFollowed ? UIColor.red : UIColor.systemBlue
    }
    
}
