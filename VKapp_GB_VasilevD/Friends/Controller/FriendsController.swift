//
//  FriendsController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 23/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class FriendsController: UITableViewController {

    var friends = [Friend]()
    let networkService = NetworkService(token: Session.instance.accessToken)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.loadFriends() { [weak self] friend in
            self?.friends = friend
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - System functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
            cell.configure(with: friends[indexPath.row])
            return cell
    }
    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsPhotoSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let photoVC = segue.destination as? FriendsPhotoController {
            let friend = friends[indexPath.row]
            photoVC.friend = friend
            photoVC.ownerId = friend.id
        }
    }

}
