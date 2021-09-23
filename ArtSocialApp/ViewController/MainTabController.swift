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
        
        let controller  =  FeedController(collectionViewLayout: layout)
        let navController  =    UINavigationController(rootViewController: controller)
        navController.tabBarItem =  UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let controller1 =  UIViewController()
        controller1.tabBarItem =  UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        let controller2 =  UIViewController()
        controller2.tabBarItem =  UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        
        let controller3 =  UIViewController()
        controller3.tabBarItem =  UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        
        
        let controller4 =  UIViewController()
        controller4.tabBarItem =  UITabBarItem(tabBarSystemItem: .bookmarks, tag: 4)
        
        viewControllers =  [navController, controller1,controller2,controller3,controller4]
    }
    
    //MARK - HELPER FUNCTION 
}
