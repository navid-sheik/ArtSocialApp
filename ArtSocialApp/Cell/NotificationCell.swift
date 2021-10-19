//
//  NotificationCell.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 13/10/2021.
//

import Foundation
import UIKit

class NotificationCell: UITableViewCell {
    var viewModel  :  NotificationViewModel?{
        didSet{
            configureUI()
        }
    }
    
    weak var notificationDelegate : NotificationCellDelegate?
    
    let imageProfile :  UIImageView  =  {
        let imageView =  UIImageView()
        imageView.backgroundColor =  .gray
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds =  true
        imageView.layer.cornerRadius = 25
    
        
        return imageView
    }()
    
    
    let notificationLabel  :  UILabel =  {
        let label  =  UILabel()
        label.text =  "username"
        label.numberOfLines  = 0
        return label
    }()
    
    lazy var postImage :  UIImageView  =  {
        let imageView =  UIImageView()
        imageView.backgroundColor =  .gray
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds =  true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePostImage)))
        
        return imageView
    }()
    
    lazy var  followButton :  UIButton = {
        let button = UIButton()
        button.setTitle("Loading", for: .normal)
        button.addTarget(self, action: #selector(handleFollowButton), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: FUNCTION
    
    private func setUpViews (){
        contentView.addSubview(imageProfile)
        imageProfile.anchor(leading: leadingAnchor, paddingLeft: 10)
        imageProfile.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageProfile.setDimension(width: 50, height: 50)
        
        contentView.addSubview(postImage)
        postImage.anchor(trailing: trailingAnchor, paddingRight: 10)
        postImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        postImage.setDimension(width: 50, height: 50)
        
        contentView.addSubview(followButton)
        followButton.anchor(trailing: trailingAnchor, paddingRight: 10)
        followButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        followButton.setDimension(width: 50, height: 15)
        
        contentView.addSubview(notificationLabel)
        notificationLabel.anchor(leading: imageProfile.trailingAnchor, trailing: postImage.leadingAnchor, paddingLeft: 10, paddingRight: 10)
        notificationLabel.centerYAnchor.constraint(equalTo: imageProfile.centerYAnchor).isActive = true
        
   

    }
    
     func configureUI(){
        guard let viewModel =  viewModel else {return}
        notificationLabel.text = "\(viewModel.username)   \(viewModel.notificationText)"
        if  let postUrl = viewModel.postImage {
            postImage.sd_setImage(with: postUrl, completed: nil)
        }
       
        
        postImage.isHidden = viewModel.isFollowType
        followButton.isHidden =  !viewModel.isFollowType
        
        
        followButton.setTitle(viewModel.buttonText, for: .normal)
        followButton.backgroundColor  =  viewModel.backgroundFollowBUtton

       
        
        
    }
    
    @objc func handleFollowButton (){
        guard let viewModel =  viewModel else {return}
        if ((viewModel.notification.isUserFollowed)){
            notificationDelegate?.unfollowUser(self, wantToFollow: viewModel.notification.uid)
            
        }else {
            notificationDelegate?.followUser(self, wantToFollow: viewModel.notification.uid)
        }
    }
    
    @objc func handlePostImage (){
        guard let viewModel =  viewModel else {return}
        notificationDelegate?.showPost(self, wantToShowForPost: viewModel.notification.postId)
        
    }
}
