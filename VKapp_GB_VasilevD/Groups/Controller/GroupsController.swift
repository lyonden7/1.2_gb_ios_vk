//
//  GroupsController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 23/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class GroupsController: UITableViewController {

    let networkService = NetworkService()
    let token = Session.instance.accessToken
    var groups = [Group]()
    
    fileprivate lazy var filteredGroups = self.groups
    
    
    // MARK: - System function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.loadGroups(token: token) { [weak self] group in
            self?.groups = group
            self?.tableView.reloadData()
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
            
            guard !groups.contains(where: { group -> Bool in
                group.name == newGroup.name
            }) else { return }
            
            groups.append(newGroup)
            
            filterGroups(with: searchBar.text ?? "")
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
        let group = filteredGroups[indexPath.row]
        
        cell.configure(with: group)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let groupToDelete = filteredGroups[indexPath.row]
            filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            groups.removeAll { group -> Bool in
                return group.name == groupToDelete.name
            }
        }
    }

}


    // MARK: - UISearchBarDelegate
extension GroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filterGroups(with: searchText)
    }
    
    fileprivate func filterGroups(with text: String) {
        if text.isEmpty {
            filteredGroups = groups
            tableView.reloadData()
            return
        }
        filteredGroups = groups.filter { $0.name.lowercased().contains(text.lowercased())}
        tableView.reloadData()
    }
}
