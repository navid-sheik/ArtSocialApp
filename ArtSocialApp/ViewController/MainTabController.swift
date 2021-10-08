//
//  MainTabController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit
import FirebaseAuth

class MainTabController : UITabBarController{
    
    //MARK - Properties
    var user : User?{
        didSet{
            setUpViews()
        }
    }
    
    
    //MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentUser()
        checkIfUserLogged()
    }
    
    
    //MARK: API
    
    private func fetchCurrentUser (){
        guard let uid  =  Auth.auth().currentUser?.uid else {return}
        UserService.fetchUser(uid: uid) { (user) in
            self.navigationItem.title =  user.userName
            self.user = user
        }
    }
    
    
    //MARK - FUNCTION
    private func checkIfUserLogged (){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let controller  =  LoginController()
                controller.delegateAuthetication = self
                let navController  =  UINavigationController(rootViewController: controller)
                navController.modalPresentationStyle =  .fullScreen
                self.present(navController, animated: true, completion: nil)
                
            }
        }
        
    }
    
    private func setUpViews (){
        let layout =  UICollectionViewFlowLayout()
        
        
        let feed  =  createNavViewController(imageNormal: UIImage(systemName: "house") ,
                                             imageSelected: UIImage(systemName: "house.fill"),
                                             controller: FeedController(collectionViewLayout: layout), tag: 0)
        
        
        let explore  =  createNavViewController(imageNormal: UIImage(systemName: "paintpalette") ,
                                                imageSelected: UIImage(systemName: "paintpalette.fill"),
                                                controller: ExploreController(), tag: 1)
        
        
        let layoutSearch =  UICollectionViewFlowLayout()
        let search = createNavViewController(imageNormal: UIImage(systemName: "magnifyingglass") ,
                                             imageSelected: UIImage(systemName: "magnifyingglass"),
                                             controller: SearchController(collectionViewLayout: layoutSearch), tag: 2)
        
        
        let layoutProfile  = UICollectionViewFlowLayout()
        guard let user = user else {return}
        let profileContoller  = ProfileController(user: user)
        profileContoller.uploadPostDelegate = self
        let profile  =  createNavViewController(imageNormal: UIImage(systemName: "person") ,
                                                imageSelected: UIImage(systemName: "person.fill"),
                                                controller: profileContoller, tag: 3)
        
        viewControllers =  [feed, explore, search , profile]
    }
    
    //MARK - HELPER FUNCTION
    
    private func createNavViewController(imageNormal  : UIImage?,
                                         imageSelected : UIImage?,
                                         controller : UIViewController, tag : Int ) -> UINavigationController{
        
        controller.tabBarItem.tag = tag
        controller.tabBarItem.image =  imageNormal
        controller.tabBarItem.selectedImage =  imageSelected
        let navController  = UINavigationController(rootViewController: controller)
        return navController
    }
}

extension MainTabController : AuthenticationDelegate{
    func reFetchUserData() {
        print("Delegate clicked")
        
        self.dismiss(animated: true, completion: nil)
        fetchCurrentUser()
        //setUpViews()
        
    }
    
    
}

extension MainTabController : PostUploaderDelegate{
    func didFinishUploading(_ postController: UploadPostController) {
        selectedIndex = 0
        postController.dismiss(animated: true, completion: nil)
        
        guard let feedNav =  viewControllers?.first as? UINavigationController else{return}
        guard let feed =  feedNav.viewControllers.first as? FeedController else{return}
        feed.handleRefreshing()
        
        //        guard let profileNav =  viewControllers?.last as? UINavigationController else{return}
        //        guard let profile =  feedNav.viewControllers.last as? ProfileController else{return}
        //        //profile.handleRefreshing()
        //        profile.getUserPosts()
        
        
    }
    
    
}
