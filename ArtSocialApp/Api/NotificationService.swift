//
//  NotificationService.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 12/10/2021.
//

import Foundation
import Firebase
import FirebaseFirestore


enum NotificationType  : Int{
    case like
    case follow
    case comment
    
    var messageNotification : String{
        switch self {

        case .like:
            return "liked your post."
        case .follow:
            return "is following you."
        case .comment:
            return "commented your post."
        }
    }
}


class NotificationService{
    static func uploadNotication (to uid : String, fromUser user: User, type : NotificationType, post : Post?){
        
        guard let currentUid  = Auth.auth().currentUser?.uid else {return}
        guard currentUid != uid else {return}
     
        let docRef  = COLLECTION_NOTIFICATION.document(uid)
        
        var data : [String : Any] =
            [
                "timestamp" : Timestamp(date: Date()),
                "fromUsername" : user.userName,
                "type" : type.rawValue,
                "id": docRef.documentID,
                "uid" : currentUid
                
            ]
        
        if let post  =  post{
            data["postId"] =  post.postId
            data["postUrl"] =  post.imageUrl
        }
        docRef.collection("user-notifications").addDocument(data: data)
    }
    
    
    static func getAllNotifications(uid : String, completion:  @escaping ([Notification]) -> Void){
        COLLECTION_NOTIFICATION.document(uid).collection("user-notifications").getDocuments { (snapshot, error) in
            if let error  = error{
                print("Fetching problem  \(error.localizedDescription) ")
            }
            guard let documents  =  snapshot?.documents else {return}
            let notifcations  = documents.map { (Notification(dict: $0.data()) )}
            completion(notifcations)
        }
    }
    
}
