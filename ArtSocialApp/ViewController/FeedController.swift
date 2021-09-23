//
//  FeedController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit
import FirebaseAuth


class FeedController  : UICollectionViewController {
    
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor =  .yellow
        setUpNavigationController()
    }
    
    //MARK: - FUNCTION
    
    private func setUpNavigationController  (){
        navigationItem.title = "Something"
        navigationItem.leftBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(hadndleLogOut))
    }
    
    
    //MARK: - ACTION
    @objc func hadndleLogOut(){
        do{
            try Auth.auth().signOut()
            let controller  =  LoginController()
            let navController  =  UINavigationController(rootViewController: controller)
            navController.modalPresentationStyle =  .fullScreen
            self.present(navController, animated: true, completion: nil)
            
        }catch{
            print("DEBUG: can't logout from the app")
        }
        
    }
}
