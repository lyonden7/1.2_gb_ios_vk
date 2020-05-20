//
//  Group.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 30/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

struct GroupResponse: Codable {
    let response: GroupObject
}

struct GroupObject: Codable {
    let items: [Group]
}

struct Group: Codable {
    let name: String
    let groupAvatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case groupAvatarUrl = "photo_50"
    }
}


//{
//"response": {
//    "count": 73,
//    "items": [
//        {
//            "id": 20845272,
//            "name": "Интересная Москва",
//            "screen_name": "vk_moscow",
//            "is_closed": 0,
//            "type": "page",
//            "is_admin": 0,
//            "is_member": 1,
//            "is_advertiser": 0,
//            "photo_50": "https://sun1-91.userapi.com/c855120/v855120657/687cf/axhSfS99OQA.jpg?ava=1",
//            "photo_100": "https://sun1-16.userapi.com/c855120/v855120657/687ce/geDSVleMDws.jpg?ava=1",
//            "photo_200": "https://sun1-25.userapi.com/c855120/v855120657/687cd/9Bk758oDLA0.jpg?ava=1"
//        },
