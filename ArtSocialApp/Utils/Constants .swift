//
//  Constants .swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 22/09/2021.
//

import Foundation
import UIKit
import Firebase

let COLLECTION_USERS =  Firestore.firestore().collection("users")

let COLLECTION_FOLLOWERS =  Firestore.firestore().collection("followers")

let COLLECTION_FOLLOWINGS =  Firestore.firestore().collection("followings")

let COLLECTION_POSTS = Firestore.firestore().collection("posts")
