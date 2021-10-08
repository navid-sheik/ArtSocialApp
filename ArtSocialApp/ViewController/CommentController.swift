//
//  CommentControlle.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 03/10/2021.
//

import Foundation
import UIKit

let commentIdentifierCell : String =  "commentIdentifierCell"

class CommentController : UICollectionViewController{
    
    //MARK: PROPRIETIES
    var post: Post
    var comments  = [Comment]()
    
    lazy var inputAccessory : CustomInputAccessoryView = {
        let frame  =  CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let inputAccessory = CustomInputAccessoryView(frame: frame)
        //inputAccessory.backgroundColor = .blue
        inputAccessory.delegateAccesory = self
        return inputAccessory
    }()
    
    //MARK: LIFECYCLE
    init(post : Post) {
        
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .white
        setUpNavigationController()
        setUpColletionView()
        fetchComments()
    }
    
    
    
    
    
    override var inputAccessoryView: UIView?{
        get{return inputAccessory}
        
    }
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    //MARK: API
    private func fetchComments (){
        CommmentService.getAllComments(postID: post.postId) { (comments) in
            self.comments =  comments
            self.collectionView.reloadData()
        }
    }
    
    
    //MARK: FUNCTION
    
    
    private func setUpNavigationController (){
        navigationItem.title =  "Comments"
    }
    private func setUpColletionView (){
        collectionView.backgroundColor = .white
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: commentIdentifierCell)
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .interactive
        collectionView.alwaysBounceVertical = true
        
    }
    
}

extension CommentController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentIdentifierCell, for: indexPath) as! CommentCell
        //cell.backgroundColor =  .blue
        cell.commentViewModel  =  CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
}


extension CommentController :  UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        let height  = viewModel.size(width: view.frame.width).height + 32
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid  =  comments[indexPath.row].userId
        UserService.fetchUser(uid: uid) { (user) in
            let controller =  ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}


extension CommentController: CustomInputAccessoryViewDelegate{
    func postNewCommment(_ accessoryView: CustomInputAccessoryView, comment: String) {
        accessoryView.clearTextView()
        print("\(comment)")
        
        guard let tabNav  =  self.tabBarController as? MainTabController else {
            return
        }
        guard let  user  = tabNav.user else {return}
        
        
        show(true)
        CommmentService.uploadComment(postID: post.postId, user: user, comment: comment) { (error) in
            self.show(false)
            if let error = error{
                return
            }
            
        }
    }
    
    
}
