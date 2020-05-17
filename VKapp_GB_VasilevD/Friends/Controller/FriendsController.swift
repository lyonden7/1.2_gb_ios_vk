//
//  FriendsController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 23/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class FriendsController: UITableViewController {

    let friends = User.getFriends()
    let networkService = NetworkService()
    
    
    // MARK: - Sort
    
    var firstCharacters = [Character]()
    var sortedFriends: [Character: [User]] = [:]
    
    private func sort(_ friends: [User]) -> (characters: [Character], sortedFriends: [Character: [User]]) {
        
        var characters = [Character]()
        var sortedFriends = [Character: [User]]()
        
        friends.forEach { friend in
            guard let character = friend.firstName.first else { return }
            if var thisCharFriends = sortedFriends[character] {
                thisCharFriends.append(friend)
                sortedFriends[character] = thisCharFriends
            } else {
                sortedFriends[character] = [friend]
                characters.append(character)
            }
        }
        characters.sort()
        
        return (characters, sortedFriends)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (firstCharacters, sortedFriends) = sort(friends)
        
        networkService.loadFriends(token: Session.instance.accessToken)
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
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return firstCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let character = firstCharacters[section]
        let friendsCount = sortedFriends[character]?.count
        return friendsCount ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        let character = firstCharacters[indexPath.section]
        if let friends = sortedFriends[character]{
            cell.userNameLabel.text = "\(friends[indexPath.row].firstName) \(friends[indexPath.row].lastName)"
            
            if friends[indexPath.row].avatar == nil {
                cell.avatarView.userAvatarView.image = UIImage(named: "horse")
            } else {
                cell.avatarView.userAvatarView.image = friends[indexPath.row].avatar
            }
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let character = firstCharacters[section]
        return String(character)
    }
    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsPhotoSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let photoVC = segue.destination as? FriendsPhotoController {
            let character = firstCharacters[indexPath.section]
            if let friends = sortedFriends[character] {
                let friend = friends[indexPath.row]
                let photos = friend.photos
                photoVC.photos = photos
                photoVC.friend = friend
            }
        }
    }

}
