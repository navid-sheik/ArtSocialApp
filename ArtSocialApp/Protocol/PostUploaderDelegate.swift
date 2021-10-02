//
//  PostUploaderDelegate.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 01/10/2021.
//

import Foundation
import UIKit

protocol PostUploaderDelegate  : class{
    func didFinishUploading  (_ postController : UploadPostController)
}
