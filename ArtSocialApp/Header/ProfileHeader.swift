//
//  ProfileHeader.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 23/09/2021.
//

import Foundation
import UIKit


private let  previewCellIdentifier : String  = "previewCellIdentifier"


class ProfileHeader : UICollectionReusableView{
    
    weak var profileDelegate : ProfileHeaderDelegate?
    
    var profileHeaderModel : ProfileViewModel?{
        didSet{
            configureUI()
        }
    }
    
    //MARK: PROPRIETIES
    private let wallpaperBackground : UIImageView = {
        let imageView =  UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "postPlaceholder")
        return imageView
        
    }()
    
    
    private let profileIcon : UIImageView = {
        let imageView =  UIImageView()
        imageView.image =  UIImage(named: "logoPlaceholder")
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius =  10
//        imageView.layer.borderWidth =  2
//        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
        
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text =  "Full Name"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font =  UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let websiteLabel : UILabel = {
        let label = UILabel()
        label.text =  "Website"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font =  UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.text =  "Bio"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font =  UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    
    private lazy var followersLabel  : UILabel = {
        let label = UILabel()
        //label.attributedText =  createCustomLabel(0, "Followers")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingLabel  : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
       //label.attributedText =  createCustomLabel(0, "Following")
        return label
    }()
    
    private lazy var buyersLabel  : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        //label.attributedText =  createCustomLabel(0, "Buyers")
        return label
    }()
    
    private lazy var editProfileImgBtn : UIImageView = {
        let imageView  = UIImageView()
        //imageView.image =  UIImage(systemName: "pencil.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.setDimension(width: 40, height: 40)
        return imageView
    }()
    
    private var  settingImgBtn : UIImageView = {
        let imageView  = UIImageView()
        imageView.image =  UIImage(systemName: "gear")
        imageView.contentMode = .scaleAspectFit
        imageView.setDimension(width: 30, height: 30)
        return imageView
    }()
    
    
    private var paintingBtn : UIButton = {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "paintbrush"), for: .normal)
        button.setImage(UIImage(systemName: "paintbrush.fill"), for: .selected)
        button.tintColor = .black
        return button
    }()
    
    
    private var postBtn  : UIButton = {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "doc"), for: .normal)
        button.setImage(UIImage(systemName: "doc.fill"), for: .selected)
        button.tintColor = .black
        return button
    }()
    
    private var purchasedBtn : UIButton = {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "banknote"), for: .normal)
        button.setImage(UIImage(systemName: "banknote.fill"), for: .selected)
        button.tintColor = .black
        return button
    }()
    
    private lazy var previewColletionView : UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
    
        
        return cv
    }()
    
    
    private lazy var uploadMessageButton : UIButton =  {
        let button =  UIButton(type: .system)
        button.layer.cornerRadius =  5
        button.backgroundColor =  .black
        //button.setTitle("UPLOAD", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //button.setHeight(height: 35)
        button.addTarget(self, action: #selector(handleUploadMessageAndPhoto), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
        
    }()
    
    //MARK: INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .red
        setUpCollectionView()
        setUpViews()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    //MARK: FUNCTION
    private func setUpViews (){
        addSubview(wallpaperBackground)
        wallpaperBackground.anchor(top: safeAreaLayoutGuide.topAnchor,leading: leadingAnchor, trailing: trailingAnchor)
        wallpaperBackground.setHeight(height: 100)

        addSubview(editProfileImgBtn)
        editProfileImgBtn.anchor(top: wallpaperBackground.bottomAnchor,  trailing: trailingAnchor,  paddingTop: 12,  paddingRight: 12)
        
      
        addSubview(profileIcon)
        profileIcon.setDimension(width: 110, height: 110)
        profileIcon.anchor(top: wallpaperBackground.bottomAnchor, leading: leadingAnchor, paddingTop: -25, paddingLeft: 12)
        
       
        
        
        let userInfoStackView  = UIStackView(arrangedSubviews: [nameLabel, websiteLabel, bioLabel])
        userInfoStackView.axis = .vertical
        userInfoStackView.spacing = 2
        addSubview(userInfoStackView)
        userInfoStackView.anchor(top: wallpaperBackground.bottomAnchor ,leading: profileIcon.trailingAnchor,  paddingTop: 12, paddingLeft: 12)
        
        
        let followStackView =  UIStackView(arrangedSubviews: [followersLabel, followingLabel, buyersLabel])
        followStackView.axis =  .horizontal
        followStackView.distribution =  .fillEqually
        addSubview(followStackView)
        followStackView.anchor(top: profileIcon.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 20, paddingLeft: 0, paddingRight: 0)
        
        
        let navigationStackView  = UIStackView(arrangedSubviews: [paintingBtn, postBtn, purchasedBtn])
        navigationStackView.setHeight(height: 50)
        navigationStackView.axis =  .horizontal
        navigationStackView.distribution =  .fillEqually
        addSubview(navigationStackView)
        navigationStackView.anchor(leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor,  paddingLeft: 0, paddingRight: 0)
//        addSubview(previewColletionView)
//        previewColletionView.anchor(top: followStackView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 12)
//        previewColletionView.setHeight(height: 100)
        addSubview(uploadMessageButton)
        uploadMessageButton.anchor(top: followStackView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: navigationStackView.topAnchor, paddingTop: 15, paddingLeft: 10, paddingRight: 10 , paddingBottom: 10)
        

        
        editProfileImgBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEditActionBtn)))
        
    }
    
    private func setUpCollectionView(){
        previewColletionView.dataSource = self
        previewColletionView.delegate = self
        previewColletionView.register(ProfileCell.self, forCellWithReuseIdentifier: previewCellIdentifier)


    
    }

    
    
    //MARK: HELPER FUNCTION
    private func createCustomLabel (_ number : Int, _ label : String ) -> NSMutableAttributedString{
        let mainString =  NSMutableAttributedString(string: "\(number)\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        mainString.append(NSAttributedString(string: "\(label)", attributes:  [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        return mainString
        
    }
    
    private func  configureUI(){
        
        guard let viewModel = profileHeaderModel else {return}
        
        self.nameLabel.text = viewModel.fullName
        self.editProfileImgBtn.image =  UIImage(systemName: viewModel.typeUserImageBtn)
        self.followersLabel.attributedText =  viewModel.userFollowers
        self.followingLabel.attributedText =  viewModel.userFollowing
        self.buyersLabel.attributedText =  viewModel.userBuyers
        self.uploadMessageButton.setTitle(viewModel.butttonProfileText, for: .normal)
        
    
        
    }
    //MARK: ACTIONS
    @objc private func handleEditActionBtn(){
        guard let profileHeder =   profileHeaderModel else {return}
        profileDelegate?.tapUser(user: profileHeder.user )
      
    }
    
    @objc private func handleUploadMessageAndPhoto(){
        guard let profileHeder =   profileHeaderModel else {return}
        profileDelegate?.uploadPhotoAndMessage(user: profileHeder.user )
    }
}


extension ProfileHeader : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
 
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = previewColletionView.dequeueReusableCell(withReuseIdentifier: previewCellIdentifier, for: indexPath) as! ProfileCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let width  =  (previewColletionView.frame.width - 46 ) / 4
        return CGSize(width: previewColletionView.frame.width, height: previewColletionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
   
    
}

