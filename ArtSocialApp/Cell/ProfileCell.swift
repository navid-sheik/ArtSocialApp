//
//  ProfileCell.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 23/09/2021.
//

import Foundation
import UIKit

class ProfileCell : UICollectionViewCell{
    //MARK: PROPETIES
    
    
    private let imageFill  : UIImageView  =  {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "sampleImage")
        return imageView
        
    }()
    
    //MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageFill)
        imageFill.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
