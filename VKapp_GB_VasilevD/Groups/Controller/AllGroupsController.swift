//
//  AllGroupsController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 23/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController {

    @IBOutlet var searchBar: UISearchBar!
    
    let networkService = NetworkService(token: Session.instance.accessToken)
    var groups = [Group]()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
        let group = groups[indexPath.row]

        cell.configure(with: group)
        return cell
    }
}

extension AllGroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filterGroups(with: searchText)
    }
        
    private func filterGroups(with text: String) {
        networkService.loadSearchGroups(for: text) { [weak self] group in
            self?.groups = group
            self?.tableView.reloadData()
        }
    }
}
