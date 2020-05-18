//
//  GroupsCell.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 29/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit
import AlamofireImage

class GroupsCell: UITableViewCell {

    @IBOutlet var groupNameLabel: UILabel!
    @IBOutlet var groupAvatarView: UIImageView!
    
    public func configure(with group: Group){
        groupNameLabel.text = group.name
        
        let groupAvatarUrlString = group.groupAvatarUrl
        groupAvatarView.af.setImage(withURL: URL(string: groupAvatarUrlString)!)
    }
}
