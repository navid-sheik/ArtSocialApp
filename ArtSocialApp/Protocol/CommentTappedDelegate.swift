//
//  CommentTappedDeleaget.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 03/10/2021.
//

import Foundation
import UIKit

protocol CommentTappedDelegate : class {
    func pushToCommentController (_ cell : FeedCell, wantsToShowCommentsFor post : Post)
}
