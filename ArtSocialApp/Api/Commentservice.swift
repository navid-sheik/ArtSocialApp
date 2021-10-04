//
//  Commentservice.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 03/10/2021.
//

import Foundation
import UIKit
import Firebase

class CommmentService {
    
    static func uploadComment (postID : String, user: User ,comment : String , completion : @escaping(FirestoreCompletion)){
        
        let data  : [String : Any]  =
            [
                "userId" : user.uid,
                "timestamp" :  Timestamp(date: Date()),
                "comment" : comment,
                "username" : user.userName
            ]
 
        
        COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
        
        
    }
    
    static func getAllComments (postID : String, completion: @escaping([Comment]) -> Void){
        var comments  =  [Comment]()
        let query =  COLLECTION_POSTS.document(postID).collection("comments").order(by: "timestamp", descending: true)
        
        //wheever a comment is added to the comments in database , refecthing automatically without calling
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ (change) in
                if change.type ==  .added{
                    let dictonary  =  change.document.data()
                    let comment = Comment(dict: dictonary)
                    comments.append(comment)
                }
            })
            completion(comments)
        }
    }
}
