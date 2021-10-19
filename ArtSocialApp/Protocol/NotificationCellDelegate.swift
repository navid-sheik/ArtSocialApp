//
//  NotificationCellDelegate.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 18/10/2021.
//

import Foundation


protocol NotificationCellDelegate : class{
    func followUser(_ cell : NotificationCell, wantToFollow : String)
    func unfollowUser(_ cell : NotificationCell , wantToFollow : String)
    func showPost(_ cell : NotificationCell, wantToShowForPost  postId: String?)
}
