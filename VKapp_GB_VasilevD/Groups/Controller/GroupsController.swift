//
//  GroupsController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 23/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsController: UITableViewController {

    let networkService = NetworkService(token: Session.instance.accessToken)
    var groups: Results<Group>?
    var token: NotificationToken?
//    var groups = [Group]()
    
    fileprivate lazy var filteredGroups = self.groups
    
    // MARK: - System function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGroupsDataFromRealm()
        
        networkService.loadGroups() { [weak self] in
            self?.loadGroupsDataFromRealm()
//            self?.groups = group
//            self?.filteredGroups = group
//            self?.tableView.reloadData()
            self?.pairTableAndRealm()
        }
    }
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        groups = realm.objects(Group.self)
        token = groups!.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
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
    
    func loadGroupsDataFromRealm() {
        do {
            let realm = try Realm()
            let groups = realm.objects(Group.self)
            self.groups = groups
        } catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    // MARK: - Add groups
    
    @IBOutlet var searchBar: UISearchBar!
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let allGroupsVC = segue.source as? AllGroupsController,
                let indexPath = allGroupsVC.tableView.indexPathForSelectedRow else { return }
            
            let newGroup = allGroupsVC.groups[indexPath.row]
            
            guard !groups!.contains(where: { group -> Bool in
                group.name == newGroup.name
            }) else { return }
            
//            groups.append(newGroup)
            
            filterGroups(with: searchBar.text ?? "")
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filteredGroups.count
        return groups!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
//        let group = filteredGroups[indexPath.row]
        let group = groups![indexPath.row]
        
        cell.configure(with: group)
        return cell
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let groupToDelete = filteredGroups![indexPath.row]
//            filteredGroups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//            groups.removeAll { group -> Bool in
//                return group.name == groupToDelete.name
//            }
//        }
//    }

}


    // MARK: - UISearchBarDelegate
extension GroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filterGroups(with: searchText)
    }
    
    fileprivate func filterGroups(with text: String?) {
        let text = text ?? ""
        if text.isEmpty {
            filteredGroups = groups
            tableView.reloadData()
            return
        }
//        filteredGroups = groups!.filter { $0.name.lowercased().contains(text.lowercased())}
        tableView.reloadData()
    }
}
