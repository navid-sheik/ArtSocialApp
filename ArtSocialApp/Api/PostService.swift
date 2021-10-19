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
    
    
    static func singlePost (postID : String , completion : @escaping(Post) -> Void){
        COLLECTION_POSTS.document(postID).getDocument { (snapshot, error) in
            if let error = error {
                print("There is an error fetching post \(error.localizedDescription)")
            }
            guard let data  = snapshot?.data() else {return}
            let post  = Post(postId: postID, dictonary: data)
            
            completion(post)

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
    
    
    static func likePost(post: Post, completion : @escaping(FirestoreCompletion)){
        
        guard let uid  = Auth.auth().currentUser?.uid else {return}
        COLLECTION_POSTS.document(post.postId).updateData(["likes" : post.likes + 1])
        COLLECTION_POSTS.document(post.postId).collection("likes-post").document(uid).setData([:]) { (error) in
            if let error =  error {
                print("DEBUG : There is an error adding likes in the post \(error.localizedDescription)")
                
            }
            
            COLLECTION_USERS.document(uid).collection("liked-posts").document(post.postId).setData([:], completion: completion)
        }
    }
    
    
    
    static func unlikePost(post: Post,  completion : @escaping(FirestoreCompletion)){
        guard let uid  = Auth.auth().currentUser?.uid else {return}
        
        guard post.likes >= 0 else {return}
        COLLECTION_POSTS.document(post.postId).updateData(["likes" : post.likes - 1])
        COLLECTION_POSTS.document(post.postId).collection("likes-post").document(uid).delete { (error) in
            if let error =  error {
                print("DEBUG : There is an error adding likes in the post \(error.localizedDescription)")
                
            }
            
            COLLECTION_USERS.document(uid).collection("liked-posts").document(post.postId).delete( completion: completion)
        }
        
        
    }
    
    static func checkIfPostLiked(post : Post, completion : @escaping (Bool) -> Void){
        
        guard let uid  = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_USERS.document(uid).collection("liked-posts").document(post.postId).getDocument { (snapshot, error) in
            if let error = error {
                print("DEBUG: There is error fetching like \(error.localizedDescription)")
            }
            guard let isLiked  =  snapshot?.exists  else {return}
            
            completion(isLiked)
        }
        
    }
    
    
    
    
}
