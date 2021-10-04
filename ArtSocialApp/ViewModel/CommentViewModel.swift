//
//  CommentViewModel.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 04/10/2021.
//

import Foundation
import UIKit

class CommentViewModel {
    var comment : Comment
   
    
    
    
    
    
    
    init(comment : Comment) {
        self.comment = comment
        
    }
    
    func createLabeTxt() -> NSAttributedString{
        
        let attributedTxt =  NSMutableAttributedString(string: "\(comment.username)  ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        
        
        attributedTxt.append(NSAttributedString(string: "\(comment.comment)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        
        return attributedTxt
    }
    
     func size (width : CGFloat) -> CGSize{
        let label  =  UILabel()
        label.numberOfLines = 0
        label.text =  comment.comment
        label.lineBreakMode =  .byWordWrapping
        label.setWidth(width: width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
