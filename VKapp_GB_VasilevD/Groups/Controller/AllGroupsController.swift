//
//  AllGroupsController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 23/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController {

    let networkService = NetworkService()
    let token = Session.instance.accessToken
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.loadSearchGroups(token: token)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
//        let group = groupNames[indexPath.row]
        
//        cell.groupNameLabel.text = group.name
//        if group.avatar == nil {
//            cell.groupAvatarView.image = UIImage(named: "horse")
//        } else {
//            cell.groupAvatarView.image = group.avatar
//        }

        return cell
    }

}
