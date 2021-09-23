//
//  Uploader.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 22/09/2021.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage

class Uploader {
    static func uploadProfilePic(image : UIImage, completion : @escaping(String) -> Void) {
        guard let imageData =  image.jpegData(compressionQuality: 0.75) else {
            return
        }
        
        let fileName   =  NSUUID().uuidString
        let ref =  Storage.storage().reference().child("profile_pics").child(fileName)
        
        ref.putData(imageData, metadata: nil) { (_, error) in
            if let error  = error {
                print("DEBUG : failed to upload image  \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                if let error = error {
                    print("DEBUG : failed to download image \(error.localizedDescription)")
                    return
                }
                guard let imageUrl =  url?.absoluteString else {return}
                completion(imageUrl)
                
            }
        }
        
    }
}
