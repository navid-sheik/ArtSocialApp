//
//  UserService.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 27/09/2021.
//

import Foundation
import UIKit
import FirebaseFirestore

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
    
}
