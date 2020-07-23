//
//  FriendsController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 23/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsController: UITableViewController {

//    var friends = [Friend]()
    var friends: Results<Friend>?
    var token: NotificationToken?
    let networkService = NetworkService(token: Session.instance.accessToken)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFriendsDataFromRealm()
        
        networkService.loadFriends() { [weak self] in
            self?.loadFriendsDataFromRealm()
//            self?.tableView.reloadData()
            self?.pairTableAndRealm()
        }
    }
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        friends = realm.objects(Friend.self)
        token = friends!.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

    
    func loadFriendsDataFromRealm() {
        do {
            let realm = try Realm()
            let friends = realm.objects(Friend.self)
            self.friends = friends
        } catch {
            print(error)
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
        return friends!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
        cell.configure(with: friends![indexPath.row])
            return cell
    }
    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsPhotoSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let photoVC = segue.destination as? FriendsPhotoController {
            let friend = friends![indexPath.row]
            photoVC.friend = friend
            photoVC.ownerId = friend.id
        }
    }

}
