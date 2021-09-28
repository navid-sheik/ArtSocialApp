//
//  SearchController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit

private let searchCellIdentifier : String = "searchCellIdentifier"

class SearchController : UICollectionViewController{
    
    //MARK: PROPRIETIES
    
    var users : [User]?
    var filterdUsers  = [User]()
    
    
    var isSearching : Bool{
        return searchUserController.isActive && !searchUserController.searchBar.text!.isEmpty
    }
    
    
    lazy var searchUserController  = UISearchController(searchResultsController: nil)
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        setUpCollection()
        setUpSearchBar()
        fetchAllUsers()
    }
    
    
    
    //MARK: API
    
    private func fetchAllUsers (){
        UserService.fetchAllUsers { (users) in
            self.users =  users
            self.collectionView.reloadData()
        }
    }
    
    //MARK: FUNCTION

    private func setUpNavigationController(){
        navigationController?.navigationBar.prefersLargeTitles = false
        searchUserController.searchResultsUpdater = self
        searchUserController.hidesNavigationBarDuringPresentation = false
        searchUserController.obscuresBackgroundDuringPresentation = false
        searchUserController.searchBar.placeholder =  "Search Users"
        searchUserController.searchBar.sizeToFit()
        navigationController?.navigationItem.searchController = searchUserController
        navigationItem.titleView =  searchUserController.searchBar
        definesPresentationContext = true
       
        
    }
    
    private func setUpCollection(){
        collectionView.backgroundColor =  .white
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: searchCellIdentifier)
        collectionView.delegate = self
    }
    
    private func setUpSearchBar(){
        
    }
    
    
    
    //MARK: HELPER
    
}



//MARK: COLLECTION DELEGATE
extension SearchController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchedTxt  =  searchController.searchBar.text else {return}
        guard let users = users else {return}
        filterdUsers =  users.filter({ $0.fullName.contains(searchedTxt) || $0.userName.contains(searchedTxt)   })
        self.collectionView.reloadData()
    }
    
    
    //MARK: SERACH HELPER
    
    private func filterUsers(){
        
    }
    
}



extension SearchController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let users = users{
            return isSearching ?  filterdUsers.count : users.count
        }
        return 0
    }
}


extension SearchController{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCellIdentifier, for: indexPath) as! SearchCell
        if let users = users{
            cell.user = isSearching ?  filterdUsers[indexPath.row] : users[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let  width = (collectionView.frame.width - 25 ) / 3
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentUser  =  isSearching ?  filterdUsers[indexPath.row] :  users?[indexPath.row] else {return}
        let profile  =  ProfileController(user: currentUser)
        navigationController?.pushViewController(profile, animated: true)
        
    }
}


extension SearchController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
