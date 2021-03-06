//
//  ProfileCell.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 23/09/2021.
//

import Foundation
import UIKit
import SDWebImage

class ProfileCell : UICollectionViewCell{
    //MARK: PROPETIES
    var postViewModel : PostViewModel?{
        didSet{
            configureUI()
        }
    }
    
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
        contentView.addSubview(imageFill)
        imageFill.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: ACTION
    
    private func configureUI(){
        guard let viewModel = postViewModel else {return}
        self.imageFill.sd_setImage(with: viewModel.imageUrl, completed: nil)
    }
    
}
