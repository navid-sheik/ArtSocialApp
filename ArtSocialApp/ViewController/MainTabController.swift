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
    
    
    
    //MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        checkIfUserLogged()
    }
    
    
    
    //MARK - FUNCTION
    private func checkIfUserLogged (){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let controller  =  LoginController()
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
        
        
        let search = createNavViewController(imageNormal: UIImage(systemName: "magnifyingglass") ,
                                             imageSelected: UIImage(systemName: "magnifyingglass"),
                                             controller: SearchController(), tag: 2)
        
        
        let layoutProfile  = UICollectionViewFlowLayout()
        let profile  =  createNavViewController(imageNormal: UIImage(systemName: "person") ,
                                                imageSelected: UIImage(systemName: "person.fill"),
                                                controller: ProfileController(collectionViewLayout: layoutProfile), tag: 3)
        
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
