//
//  CommentCell.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 03/10/2021.
//

import Foundation
import UIKit

class CommentCell : UICollectionViewCell{
    
    var commentViewModel : CommentViewModel?{
        didSet{
            configureUI()
        }
    }
    
    private var profileImage : UIImageView =  {
        let imgView  = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor  =  .gray
        imgView.clipsToBounds =  true
        imgView.layer.cornerRadius =  10
        
        return imgView
    }()
    
    
    
    private var commmentLabel =  UILabel()
    
    //MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: FUNCTIONS
    
    private func setUpViews (){
        addSubview(profileImage)
        profileImage.anchor( leading: leadingAnchor,  paddingLeft: 8 )
        profileImage.setDimension(width: 40, height: 40)
        profileImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(commmentLabel)
        commmentLabel.anchor(leading : profileImage.trailingAnchor, trailing : trailingAnchor,  paddingLeft: 8 , paddingRight: 8)
        commmentLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        commmentLabel.numberOfLines = 0
    }
    
    private func configureUI(){
        guard let viewModel  = commentViewModel  else {return}
        commmentLabel.attributedText = viewModel.createLabeTxt()
    }
    
    
   
}
