//
//  Friend.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 30/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import Foundation

struct FriendResponse: Codable {
    let response: FriendObject
}

struct FriendObject: Codable {
    let count: Int
    let items: [Friend]
}

struct Friend: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let friendAvatarUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case friendAvatarUrl = "photo_50"
    }
}


//{
//"response": {
//    "count": 395,
//    "items": [
//        {
//            "id": 13574959,
//            "first_name": "Алексей",
//            "last_name": "Илясов",
//            "is_closed": false,
//            "can_access_closed": true,
//            "photo_50": "https://sun9-13.userapi.com/c845020/v845020152/ae2b9/nWlxRtrIui8.jpg?ava=1",
//            "online": 0,
//            "track_code": "fa3e0613WxKjZE96jlQdWsO4ccPg-_z0JPAMhLjOr1k2dKFp5CQ2efxcIXKEVksM-kidJCeYnPkz62nq"
//        },









//class User {
//
//    let firstName: String
//    let lastName: String
//    let avatar: UIImage?
//    let photos: [UIImage]
//
//    init(firstName: String, lastName: String, avatar: UIImage?, photos: [UIImage]) {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.avatar = avatar
//        self.photos = photos
//    }
//
//    static func getFriends() -> [User] {
//        return [
//            User(firstName: "Alan", lastName: "Dzagoev", avatar: UIImage(named: "alan")!, photos: [UIImage(named: "alan-1")!, UIImage(named: "alan-2")!, UIImage(named: "alan-3")!, UIImage(named: "alan-4")!]),
//            User(firstName: "Arnor", lastName: "Sigurdsson", avatar: UIImage(named: "arnor"), photos: [UIImage(named: "arnor-1")!, UIImage(named: "arnor-2")!, UIImage(named: "arnor-3")!, UIImage(named: "arnor-4")!]),
//            User(firstName: "Ivan", lastName: "Oblyakov", avatar: UIImage(named: "bubl"), photos: [UIImage(named: "bubl-1")!, UIImage(named: "bubl-2")!, UIImage(named: "bubl-3")!]),
//            User(firstName: "Fedor", lastName: "Chalov", avatar: UIImage(named: "chalov"), photos: [UIImage(named: "chal-1")!, UIImage(named: "chal-2")!, UIImage(named: "chal-3")!]),
//            User(firstName: "Konstantin", lastName: "Kuchaev", avatar: UIImage(named: "kuch"), photos: [UIImage(named: "kuch-1")!, UIImage(named: "kuch-2")!, UIImage(named: "kuch-3")!]),
//            User(firstName: "Kirill", lastName: "Nababkin", avatar: UIImage(named: "legenda"), photos: [UIImage(named: "legenda-1")!, UIImage(named: "legenda-2")!, UIImage(named: "legenda-3")!]),
//            User(firstName: "Hordur", lastName: "Magnusson", avatar: UIImage(named: "maga"), photos: [UIImage(named: "maga-1")!, UIImage(named: "maga-2")!, UIImage(named: "maga-3")!]),
//            User(firstName: "Mario", lastName: "Fernandes", avatar: UIImage(named: "mario"), photos: [UIImage(named: "mario-1")!, UIImage(named: "mario-2")!, UIImage(named: "mario-3")!, UIImage(named: "mario-4")!, UIImage(named: "mario-5")!]),
//            User(firstName: "Nikola", lastName: "Vlasic", avatar: UIImage(named: "niksi"), photos: [UIImage(named: "niksi-1")!, UIImage(named: "niksi-2")!, UIImage(named: "niksi-3")!]),
//            User(firstName: "Ilzat", lastName: "Akhmetov", avatar: UIImage(named: "plov"), photos: [UIImage(named: "plov-1")!, UIImage(named: "plov-2")!, UIImage(named: "plov-3")!])
//        ]
//    }
//
//}
