//
//  FriendsCell.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 29/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit
import AlamofireImage

class FriendsCell: UITableViewCell {

    @IBOutlet var friendFullNameLabel: UILabel!
    @IBOutlet var avatarView: AvatarView!
    
    public func configure(with friend: Friend){
        friendFullNameLabel.text = friend.firstName + " " + friend.lastName
        
        let friendAvatarUrlString = friend.friendAvatarUrl
        avatarView.userAvatarView.af.setImage(withURL: URL(string: friendAvatarUrlString)!)
    }
}
