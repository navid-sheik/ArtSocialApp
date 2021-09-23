//
//  AuthService.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 22/09/2021.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class AuthService {
    
    
    static func registerNewUser (userCreditials :  AuthCreditials, completion: @escaping(Bool) ->Void){
        Auth.auth().createUser(withEmail: userCreditials.email, password: userCreditials.password) { (authResult , error) in
            
            if let error  =  error {
                print("DEBUG : can't create a user \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let uid  = Auth.auth().currentUser?.uid else {return}
            
            let userDocument =
                [
                    "fullName" :  userCreditials.fullname,
                    "userName" :  userCreditials.username,
                    "email": userCreditials.email
                ]
            
            COLLECTION_USERS.document(uid).setData(userDocument)
            completion(true)
        
        }
        
    }
   
    static func logInUser(){
        
    }
}

