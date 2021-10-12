//
//  FeedController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit
import FirebaseAuth

private let feedControllerIdentifier : String =  "feedControllerIdentifier"

class FeedController  : UICollectionViewController {
    
    var singlePostSelected : Post?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var posts = [Post]() {
        didSet{
            self.collectionView.reloadData()
            
        }
    }
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor =  .white
        setUpNavigationController()
        setUpCollectionView()
        fetchFeed()
        setReferesher()
    }
    
    
    //MARK: - FUNCTION
    
    private func setUpNavigationController  (){
        if let post =  singlePostSelected{
            navigationItem.title = "Post"
            //navigationItem.leftBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(hadndleLogOut))
        }else{
            navigationItem.title = "Home"
            navigationItem.leftBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(hadndleLogOut))
        }
        
    }
    
    
    private func setUpCollectionView(){
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: feedControllerIdentifier)
        collectionView.delegate = self
        
        
    }
    
    private func setReferesher(){
        guard singlePostSelected == nil else {
            return
        }
        let refresh  =  UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleRefreshing), for: .valueChanged)
        collectionView.refreshControl = refresh
    }
    //MARK: - API
    
    private func fetchFeed(){
        guard singlePostSelected == nil else {
            return
        }
        show(true)
        PostService.getAllPost { (posts) in
            self.show(false)
            self.posts =  posts
            self.fetchIsLiked()
            self.collectionView.refreshControl?.endRefreshing()
            
            
            self.collectionView.reloadData()
        }
    }
    
    
    private func fetchIsLiked (){
        
        posts.forEach({ (post) in
            PostService.checkIfPostLiked(post: post) { (didLike) in
                if let index  =  self.posts.firstIndex(where: { $0.postId == post.postId}){
                    self.posts[index].didLike = didLike
                }
            }
        })
    }
    //MARK: - ACTION
    @objc func hadndleLogOut(){
        do{
            try Auth.auth().signOut()
            let controller  =  LoginController()
            controller.delegateAuthetication = self.tabBarController as? MainTabController
            let navController  =  UINavigationController(rootViewController: controller)
            navController.modalPresentationStyle =  .fullScreen
            self.present(navController, animated: true, completion: nil)
            
        }catch{
            print("DEBUG: can't logout from the app")
        }
        
    }
    
    @objc func handleRefreshing(){
        
        posts.removeAll()
        fetchFeed()
    }
}

//MARK: COLLECTION DELEGATE
extension FeedController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posts.count
        
    }
    
}

extension FeedController{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedControllerIdentifier, for: indexPath) as! FeedCell
        //cell.backgroundColor = .brown
        cell.delegate = self
        
        
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        
        
        if let singlePost  =  singlePostSelected{
            cell.viewModel =  PostViewModel(post: singlePost)
        }
        
        return cell
    }
    
    
}
extension FeedController : UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: 380)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}


extension FeedController : CellDelegate{
    func likePost(_ cell: FeedCell, postLikeFor post: Post) {
        cell.viewModel?.post.didLike.toggle()
        
        
        
        if post.didLike{
            print("Unlike post")
            PostService.unlikePost(post: post) { (error) in
                
                cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.viewModel?.post.likes =  post.likes - 1
                cell.configureUI()
            }
            
        }else{
            print("Like post")
            PostService.likePost(post: post) { (error) in
                
                cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.viewModel?.post.likes =  post.likes + 1
                
                cell.configureUI()
                
                guard let navController  =  self.tabBarController as? MainTabController else {return}
                guard let currentUser  = navController.user else {return}
             
                NotificationService.uploadNotication(to: post.userId, fromUser: currentUser, type: .like, post: post)
            }
            
            
            
        }
        
        
        
    }
    
    func pushToCommentController(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
        
        let controller  = CommentController( post: post)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
}
