//
//  SearchCell.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 28/09/2021.
//

import Foundation
import  UIKit

class SearchCell: UICollectionViewCell {
    

    
    //MARK: PROPRIETIES
    var user : User?{
        didSet{
            guard let user = user else {return}
            self.usernameLabel.text  = user.userName
        }
    }
    
    private let userProfile : UIImageView  = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image =  UIImage(named: "logoPlaceholder")
        return imageView
    }()
    
    private let usernameLabel : UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        label.text  = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = .systemGray5
        return label
    }()
    
    //MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor =  .brown
        setUpCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: FUNCTION
    private func setUpCell(){
        addSubview(usernameLabel)
        usernameLabel.anchor(leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
        usernameLabel.setHeight(height: 30)
        addSubview(userProfile)
        userProfile.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: usernameLabel.topAnchor)
        //userProfile.setDimension(width: 50, height: 50)
    
    }
}
