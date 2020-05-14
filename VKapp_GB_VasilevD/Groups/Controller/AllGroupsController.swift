//
//  AllGroupsController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 23/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController {

    let groupNames = [
        Group(name: "Российская Премьер-Лига", avatar: UIImage(named: "rpl")),
        Group(name: "Лига Европы", avatar: UIImage(named: "uel")),
        Group(name: "FIFA", avatar: UIImage(named: "fifa")),
        Group(name: "UEFA", avatar: UIImage(named: "uefa")),
        Group(name: "Лига Чемпионов", avatar: UIImage(named: "ucl")),
        Group(name: "Adidas", avatar: UIImage(named: "adidas")),
        Group(name: "Joma", avatar: UIImage(named: "joma")),
        Group(name: "Select", avatar: UIImage(named: "select")),
        Group(name: "Umbro", avatar: UIImage(named: "umbro"))
    ]

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupNames.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
        let group = groupNames[indexPath.row]
        
        cell.groupNameLabel.text = group.name
        if group.avatar == nil {
            cell.groupAvatarView.image = UIImage(named: "horse")
        } else {
            cell.groupAvatarView.image = group.avatar
        }

        return cell
    }

}
