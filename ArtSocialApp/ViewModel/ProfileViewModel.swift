//
//  ProfileViewModel.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 27/09/2021.
//

import Foundation
import UIKit

class ProfileViewModel {
    var user : User
    
    var userName : String{
        return user.userName
    }
    
    var email : String{
        return user.email
    }
    
    
    var fullName : String{
        return user.fullName
    }
    
    

    
    
    init(user : User) {
        self.user = user
    }
}
