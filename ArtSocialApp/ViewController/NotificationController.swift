//
//  NotificationController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 13/10/2021.
//

import Foundation
import UIKit
import FirebaseAuth

let notificationIdentifier  : String =  "notificationIdentifier"

class NotificationController: UITableViewController{
    
    //MARK: PROPRETIES
    
    let refresher =  UIRefreshControl()
    
    var notifications  = [Notification](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        setUpTableView()
        fetchNotification()

    }
    
    //MARK: FUNCTION
    
    private func setUpTableView(){
        tableView.backgroundColor = .brown 
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight =  80
       
        tableView.register(NotificationCell.self, forCellReuseIdentifier: notificationIdentifier)
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refresher
    }
    
    
    private func setNavigationController (){
        navigationItem.title =  "Notification"
    }
    
    //MARK: API
    
    func fetchNotification (){
        guard let uid  = Auth.auth().currentUser?.uid else {return}
        NotificationService.getAllNotifications(uid: uid) { (notifications) in
            self.notifications = notifications
            self.checkIfUserFollowed()
           
        }
    }
    
    
    func checkIfUserFollowed(){
        notifications.forEach { (notification) in
            UserService.checkUserFollow(otherUID: notification.uid) { (isFollowed) in
                if let index =  self.notifications.firstIndex(where: { ($0.id == notification.id)}){
                    self.notifications[index].isUserFollowed = isFollowed
                    
                }
            }
            //self.tableView.reloadData()
        }
   
    }
    
    //MARK: OBJC
    
    @objc func handleRefresh(){
        fetchNotification()
        refresher.endRefreshing()
    }
    
}


extension NotificationController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: notificationIdentifier, for: indexPath) as! NotificationCell
        cell.viewModel =  NotificationViewModel(notification: notifications[indexPath.row])
        cell.notificationDelegate = self
        return cell
    }
    
    
}


extension NotificationController: NotificationCellDelegate{
    func showPost(_ cell: NotificationCell, wantToShowForPost postId: String?) {
        print("show post ")
        guard let postID  = postId  else {return}
        PostService.singlePost(postID: postID) { (post) in
            let controller  = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
            controller.singlePostSelected = post
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func followUser(_ cell: NotificationCell, wantToFollow: String) {
        print("Follow users")
        UserService.follow(otherUID: wantToFollow) { (error) in
            cell.viewModel?.notification.isUserFollowed.toggle()
            cell.configureUI()
        }
    }
    
    func unfollowUser(_ cell: NotificationCell, wantToFollow: String) {
        print("UnFollow users")
        UserService.unfollow(otherUID: wantToFollow) { (error) in
            cell.viewModel?.notification.isUserFollowed.toggle()
            cell.configureUI()

        }
    }
   
    
    
}
