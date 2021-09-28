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
    
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor =  .white
        setUpNavigationController()
        setUpCollectionView()
    }
   
    
    //MARK: - FUNCTION
    
    private func setUpNavigationController  (){
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(hadndleLogOut))
    }
    
    
    private func setUpCollectionView(){
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: feedControllerIdentifier)
        collectionView.delegate = self
        
        
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
}

//MARK: COLLECTION DELEGATE
extension FeedController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
}

extension FeedController{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedControllerIdentifier, for: indexPath) as! FeedCell
        //cell.backgroundColor = .brown
      
        return cell
    }
    
    
}
extension FeedController : UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: 350)
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
