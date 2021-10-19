//
//  ProfileController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit
import FirebaseAuth

private let profileCellIdentifier  : String =  "profileCellIdentifier"
private let profileHeaderIdentifier : String =  "profileHeaderIdentifier"

class ProfileController : UICollectionViewController{
    
    //MARK: - PROPRIETIES
    
    var user : User
    
    weak var uploadPostDelegate : PostUploaderDelegate?
    var posts =  [Post]()
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpNavigationController()
        setUpCollectionView()
        checkUserIsFollowed()
        getUserStats()
        //fetchCurrentUser()
        
        getUserPosts()
        
    }
    
    init(user : User){
        self.user =  user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: API
    
    
    
    
    //MARK: CHECK USER IS FOLLOWED
    private func checkUserIsFollowed(){
        UserService.checkUserFollow(otherUID: user.uid) { (isFollowed) in
            if isFollowed{
                self.user.isFollowed = true
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: GET USER STATS
    private func getUserStats (){
        UserService.getUsersCount(userUID: user.uid) { (userStats) in
            self.user.userStats =  userStats
            self.collectionView.reloadData()
        }
    }
    
    func getUserPosts(){
        PostService.getUserPost(userId: user.uid) { (posts) in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
    
    
    
    //MARK: - FUNCTIONS
    private func setUpNavigationController (){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationItem.title = "Profile"
        navigationItem.title = user.userName
        navigationController?.navigationBar.isTranslucent = false
        //navigationController?.navigationBar.tintColor = .black
    }
    
    private func setUpCollectionView (){
        collectionView.backgroundColor =  .white
        collectionView.delegate = self
        
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: profileCellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: profileHeaderIdentifier)
    }
}



//MARK: - DATA SOURCE
extension ProfileController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
}

//MARK: - UICOLLECTIONVIEW DELEGATE
extension ProfileController{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellIdentifier, for: indexPath) as! ProfileCell
        //cell.backgroundColor = .blue
        cell.postViewModel =  PostViewModel(post: posts[indexPath.row])
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout  = UICollectionViewFlowLayout()
        let viewPostController  =  FeedController(collectionViewLayout: layout)
        viewPostController.singlePostSelected =  posts[indexPath.row]
        self.navigationController?.pushViewController(viewPostController, animated: true)
    }
    
    
    
}


//MARK: - UICOLLETIONVIEW FLOW DELEGATE
extension ProfileController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: profileHeaderIdentifier, for: indexPath) as! ProfileHeader
        
        header.profileHeaderModel = ProfileViewModel(user: user)
        header.profileDelegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 350)
    }
}

extension ProfileController : ProfileHeaderDelegate{
    func uploadPhotoAndMessage(user: User) {
        print("Upload photo message")
        presentImagePicker()
        
        
        
    }
    
    func tapUser(user: User) {
        //print("Tap user \(user)")
        guard let tabNav  =  self.tabBarController as? MainTabController else {
            return
        }
        guard let  currentUser  = tabNav.user else {return}

        if user.isCurrentUser{
            return
            
        }else if user.isFollowed{
            
            UserService.unfollow(otherUID: user.uid) { (error) in
                if let error =  error{
                    print("Can't follow user \(error.localizedDescription)")
                }
                
                self.user.isFollowed = false
                //Update the users stats 
                UserService.getUsersCount(userUID: user.uid) { (userStats) in
                    self.user.userStats =  userStats
                    self.collectionView.reloadData()
                }
                
            }
            
        }else {
            UserService.follow(otherUID: user.uid) { (error) in
                
                if let error =  error{
                    print("Can't follow user \(error.localizedDescription)")
                }
                
                self.user.isFollowed = true
                //Update the users stats
                UserService.getUsersCount(userUID: user.uid) { (userStats) in
                    self.user.userStats =  userStats
                    NotificationService.uploadNotication(to: user.uid, fromUser: currentUser, type: .follow, post: nil)
                    self.collectionView.reloadData()
                    
                }
            }
            
        }
        
        
    }
    
    
}


extension ProfileController :  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func presentImagePicker (){
        let picker  = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[ UIImagePickerController.InfoKey.editedImage ] as? UIImage else {
            return
        }
        
        self.dismiss(animated: true) {
            //dismiss this controller and present this controller
            let controller  =  UploadPostController(image: image, user: self.user)
            controller.delegateUploader = self.uploadPostDelegate
            let navController  =  UINavigationController(rootViewController: controller)
            navController.modalPresentationStyle  =  .fullScreen
            
            self.present(navController, animated: false, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        return
    }
}
