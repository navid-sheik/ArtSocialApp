//
//  NotificationController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 13/10/2021.
//

import Foundation
import UIKit

let notificationIdentifier  : String =  "notificationIdentifier"

class NotificationController: UITableViewController{
    
    //MARK: PROPRETIES
    
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        setUpTableView()

    }
    
    //MARK: FUNCTION
    
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight =  80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: notificationIdentifier)
        
    }
    
    
    private func setNavigationController (){
        navigationItem.title =  "Notification"
    }
}


extension NotificationController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: notificationIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
}
