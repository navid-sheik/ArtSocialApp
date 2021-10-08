//
//  PostViewModel.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 01/10/2021.
//

import Foundation
import UIKit
import Firebase

class PostViewModel{
    var post : Post
    
    var imageUrl : URL? {
        
        return URL(string: post.imageUrl)
    }
    
    var captionText : String{
        return post.caption
    }
    
    var timeStamp : Timestamp{
        return post.timestamp
    }
    
    
    var postComments : Int{
        return post.commments
    }
    
    var postLikes : Int{
        return post.likes
    }
    
    var username : String{
        return post.username
    }
    
    var likeImage : UIImage?{
        return post.didLike ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    init(post : Post) {
        self.post = post
    }
    
}
