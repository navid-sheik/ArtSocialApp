//
//  ProfileHeaderDelegate.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 28/09/2021.
//

import Foundation
import UIKit

protocol ProfileHeaderDelegate : class {
    func tapUser (user : User)
    func uploadPhotoAndMessage(user : User)
}
