//
//  GroupsController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 23/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class GroupsController: UITableViewController {

    fileprivate var groupNames = [
        Group(name: "Российская Премьер-Лига", avatar: UIImage(named: "rpl")),
        Group(name: "Лига Европы", avatar: UIImage(named: "uel"))
    ]
    
    fileprivate lazy var filteredGroups = self.groupNames
    
    
    // MARK: - System function
    override func viewDidLoad() {
        super.viewDidLoad()
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
            
            let newGroup = allGroupsVC.groupNames[indexPath.row]
            
            guard !groupNames.contains(where: { group -> Bool in
                group.name == newGroup.name
            }) else { return }
            
            groupNames.append(newGroup)
            
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
        
        cell.groupNameLabel.text = group.name
        if group.avatar == nil {
            cell.groupAvatarView.image = UIImage(named: "horse")
        } else {
            cell.groupAvatarView.image = group.avatar
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let groupToDelete = filteredGroups[indexPath.row]
            filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            groupNames.removeAll { group -> Bool in
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
            filteredGroups = groupNames
            tableView.reloadData()
            return
        }
        filteredGroups = groupNames.filter { $0.name.lowercased().contains(text.lowercased())}
        tableView.reloadData()
    }
}
