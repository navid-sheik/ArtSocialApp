//
//  FeedCell.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 28/09/2021.
//

import Foundation
import UIKit
import  SDWebImage



class FeedCell : UICollectionViewCell{
    
    //MARK: PROPETIES
    weak var delegate : CellDelegate?
    
    var viewModel : PostViewModel?{
        didSet{configureUI()}
    }
    
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
    
     lazy var likeButton : UIButton =  {
        let button = UIButton(type: .system)
        //button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLikeBtn)))
        return button
    }()
    
    private lazy var commentButton : UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCommentBtn)))
        return button
    }()
    
    private lazy var numberLikeLabel : UILabel =  {
        let label = UILabel()
        label.attributedText =  createCustomLabel(0, "Likes")
        return label
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
        
        addSubview(numberLikeLabel)
        numberLikeLabel.anchor(top: postImage.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 10)
     
        addSubview(buttonStackView)
        //buttonStackView.setHeight(height: 50)
        buttonStackView.anchor(top: numberLikeLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,bottom: bottomAnchor,  paddingTop: 0)

        
    }
    
     func configureUI(){
        guard let viewModel  = viewModel else {
            return
        }
        self.postImage.sd_setImage(with: viewModel.imageUrl, completed: nil)
        self.profileUsername.text =  viewModel.username
        self.numberLikeLabel.attributedText =  self.createCustomLabel(viewModel.postLikes, "likes")
        self.likeButton.setImage(viewModel.likeImage, for: .normal)
        
    }
    
    //MARK: ACTION
    @objc private func handleCommentBtn(){
        guard let viewModel  = viewModel else {return}
        delegate?.pushToCommentController(self, wantsToShowCommentsFor: viewModel.post)
    }
    
    @objc private func handleLikeBtn(){
        guard let viewModel  = viewModel else {return}
        delegate?.likePost(self, postLikeFor: viewModel.post)
    }
    
    
    //MARK: HELPER FUNCTION
    private func createCustomLabel (_ number : Int, _ label : String ) -> NSMutableAttributedString{
        let mainString =  NSMutableAttributedString(string: "\(number) ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        mainString.append(NSAttributedString(string: "\(label)", attributes:  [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        return mainString
        
    }

}
