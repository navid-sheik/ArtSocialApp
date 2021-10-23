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
    
    
    static func registerNewUser (userCreditials :  AuthCreditials, completion: @escaping(Error?) ->Void){
        Auth.auth().createUser(withEmail: userCreditials.email, password: userCreditials.password) { (authResult , error) in
            
            if let error  =  error {
                print("DEBUG : can't create a user \(error.localizedDescription)")
                return
            }
            
            guard let uid  = Auth.auth().currentUser?.uid else {return}
            
            let userDocument =
                [
                    "fullName" :  userCreditials.fullname,
                    "userName" :  userCreditials.username,
                    "email": userCreditials.email,
                    "uid" : uid 
                ]
            
            
            COLLECTION_USERS.document(uid).setData(userDocument, completion: completion)
            
            
        }
        
    }
    
    static func logInUser(email : String, password : String, completion: ((AuthDataResult?, Error?) -> Void)?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    
    static func resetPassword  (email : String, completion  : @escaping((SendPasswordResetCallback))){
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
}

