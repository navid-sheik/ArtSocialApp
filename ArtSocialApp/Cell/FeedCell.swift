//
//  FeedCell.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 28/09/2021.
//

import Foundation
import UIKit

class FeedCell : UICollectionViewCell{
    
    //MARK: PROPETIES
    private let profileImage :  UIImageView =  {
        let imageView  = UIImageView()
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "postPlaceholder")
        imageView.layer.cornerRadius =  25
        imageView.setDimension(width: 40, height: 40)
        return imageView
    }()
    
    private let profileUsername : UILabel = {
        let profileLabel  = UILabel()
        profileLabel.text = "Username"
        profileLabel.font =  UIFont.systemFont(ofSize: 16)
        profileLabel.textAlignment = .left
        profileLabel.numberOfLines =  1
        return profileLabel
    }()
    
    private let postImage : UIImageView =  {
        let imageView  = UIImageView()
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "postPlaceholder")
        return imageView
    }()
    
    private let likeButton : UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    private let commentButton : UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        return button
    }()
    
    
    
    
     
    //MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: FUNCTIONS
    
    private func setUpCell(){
        backgroundColor = .systemGray
        addSubview(profileImage)
        profileImage.anchor(top: topAnchor, leading: leadingAnchor, paddingTop: 12, paddingLeft: 12)
        addSubview(profileUsername)
        profileUsername.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        profileUsername.setHeight(height: 40)
        profileUsername.anchor(leading: profileImage.trailingAnchor, paddingLeft: 12)
        addSubview(postImage)
        postImage.anchor(top: profileImage.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 12)
        postImage.setHeight(height: 225)
        
        let buttonStackView  = UIStackView(arrangedSubviews: [likeButton, commentButton])
        buttonStackView.alignment = .fill
        buttonStackView.axis = .horizontal
        buttonStackView.distribution =  .fillEqually
        buttonStackView.spacing =  10
        
        addSubview(buttonStackView)
        //buttonStackView.setHeight(height: 50)
        buttonStackView.anchor(top: postImage.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,bottom: bottomAnchor, paddingTop: 0)
    }
}
