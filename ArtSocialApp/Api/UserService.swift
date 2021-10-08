//
//  UserService.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 27/09/2021.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth
typealias FirestoreCompletion = ((Error?) -> Void)


class UserService{
    
    
    static func fetchUser (uid : String, completion: @escaping(User) -> Void){
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            
            if  let error = error {
                print("DEBUG : There is a problem in fetching the user \(error.localizedDescription)")
            }
            
            guard let dictonaryUser  =  snapshot?.data() else { return}
            let user  =  User(dictnary: dictonaryUser)
            completion(user)
        }
    }
    
    
    static func fetchAllUsers(completion : @escaping([User]) -> Void){
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            
            if  let error = error {
                print("DEBUG : There is a problem in fetching all users \(error.localizedDescription)")
            }
            
            guard let snapshot =  snapshot else {return}
            let users =  snapshot.documents.map { (User(dictnary: $0.data())) }
            completion(users)
        }
    }
    
    
    static func follow(otherUID : String, completion : @escaping(FirestoreCompletion)){
        guard let currentUID  = Auth.auth().currentUser?.uid else {return}
        COLLECTION_FOLLOWINGS.document(currentUID).collection("user-following").document(otherUID).setData([:]) { (error) in
            if let error = error {
                print("Error in adding following \(error.localizedDescription)")
            }
            
            COLLECTION_FOLLOWERS.document(otherUID).collection("user-followers").document(currentUID).setData([ : ], completion: completion)
        }
    }
    
    static func unfollow(otherUID : String, completion : @escaping(FirestoreCompletion)){
        guard let currentUID  = Auth.auth().currentUser?.uid else {return}
        COLLECTION_FOLLOWINGS.document(currentUID).collection("user-following").document(otherUID).delete{ (error) in
            if let error = error {
                print("Error in adding following \(error.localizedDescription)")
            }
            
            COLLECTION_FOLLOWERS.document(otherUID).collection("user-followers").document(currentUID).delete( completion: completion)
        }
    }
    static func checkUserFollow (otherUID : String, completion : @escaping(Bool) -> Void){
        guard let currentUID  = Auth.auth().currentUser?.uid else {return}
        COLLECTION_FOLLOWINGS.document(currentUID).collection("user-following").document(otherUID).getDocument { (snaphot, error) in
            if let error = error {
                print("DEBUG : Error while checking user following \(error.localizedDescription)")
                return
            }
            guard let isFollowed  =  snaphot?.exists else {return}
            completion(isFollowed)
        }
    }
    
    
    static func getUsersCount (userUID : String , completion : @escaping(UserStats) -> Void){
        
        COLLECTION_FOLLOWINGS.document(userUID).collection("user-following").getDocuments { (snapshot, error) in
            if let error = error {
                print ("DEBUG : error fetching users followings count \(error.localizedDescription)")
                return
            }
            let followingsCount =  snapshot?.count ?? 0
            COLLECTION_FOLLOWERS.document(userUID).collection("user-followers").getDocuments { (snapshot, error) in
                if let error = error {
                    print ("DEBUG : error fetching users followes count \(error.localizedDescription)")
                    return
                }
                
                let followersCount  = snapshot?.count ?? 0
                
                let userStats  = UserStats(followers: followersCount, following: followingsCount)
                completion(userStats)
            }
            
        }
    }
}
