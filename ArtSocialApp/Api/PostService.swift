//
//  PostService.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 01/10/2021.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage




class PostService {
    
    static func uploadPosts (username: String , caption : String, postImage :  UIImage , completion  : @escaping(FirestoreCompletion)){
        guard let currentUID  =  Auth.auth().currentUser?.uid else {return}
        
        Uploader.uploadUserPost(image: postImage) { (imageUrl) in
            
            
            let data  : [String : Any] =
                [ "imageUrl" : imageUrl,
                  "userId" : currentUID,
                  "likes" : 0,
                  "commments" :  0,
                  "timestamp" : Timestamp(date: Date()),
                  "caption" : caption,
                  "username" :  username
                ]
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
            
        }
        
        
    }
    
    static func getAllPost (completion : @escaping([Post])-> Void){
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            if let error = error{
                print("There is an error getting documents \(error.localizedDescription)")
                return
            }
            
            guard let documents =  snapshot?.documents else {
                print("Snapshot is empty")
                return
            }
            
            let posts  = documents.map { (Post(postId: $0.documentID, dictonary: $0.data()))}
            completion(posts)
        }
    }
    
    
    static func getUserPost(userId : String, completion : @escaping([Post])-> Void ){
        COLLECTION_POSTS.whereField("userId", isEqualTo: userId).getDocuments { (snapshot, error) in
            if let error = error{
                print("There is an error getting documents \(error.localizedDescription)")
                return
            }
            
            guard let documents =  snapshot?.documents else {
                print("Snapshot is empty")
                return
            }
            
            let posts  = documents.map { (Post(postId: $0.documentID, dictonary: $0.data()))}
            completion(posts)
        }
    }
    
}