//
//  ProfileController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit

private let profileCellIdentifier  : String =  "profileCellIdentifier"
private let profileHeaderIdentifier : String =  "profileHeaderIdentifier"

class ProfileController : UICollectionViewController{
    
    //MARK: - PROPRIETIES
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        setUpCollectionView()
       
    }
   
    
    //MARK: - FUNCTIONS
    private func setUpNavigationController (){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationItem.title = "Profile"
        navigationItem.title = "Name"
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
        return 20
    }
}

//MARK: - UICOLLECTIONVIEW DELEGATE
extension ProfileController{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellIdentifier, for: indexPath) as! ProfileCell
        //cell.backgroundColor = .blue
        return cell
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
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 320)
    }
}

