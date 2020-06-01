//
//  Photo.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 18/05/2020.
//  Copyright © 2020 Denis Vasilev. All rights reserved.
//

import Foundation
import RealmSwift

struct PhotoResponse: Decodable {
    let response: PhotoObject
}

struct PhotoObject: Decodable {
    let items: [Photo]
}

class Photo: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var type = ""
    @objc dynamic var photoUrl = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
        case likes
    }
    
    enum SizeKeys: String, CodingKey {
        case type
        case photoUrl = "url"
    }
    
//    override static func primaryKey() -> String? {
//        return "photoUrl"
//    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let photoContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try photoContainer.decode(Int.self, forKey: .id)
        self.ownerId = try photoContainer.decode(Int.self, forKey: .ownerId)
        
        var sizesContainer = try photoContainer.nestedUnkeyedContainer(forKey: .sizes)
        
        while !sizesContainer.isAtEnd {
            let sizesValues = try sizesContainer.nestedContainer(keyedBy: SizeKeys.self)
            let photoType = try sizesValues.decode(String.self, forKey: .type)
            switch photoType {
            case "x":
                self.photoUrl = try sizesValues.decode(String.self, forKey: .photoUrl)
            case "m":
                self.photoUrl = try sizesValues.decode(String.self, forKey: .photoUrl)
            default:
                break
            }
        }

    }
}


//{
//"response": {
//    "count": 3253,
//    "items": [
//        {
//            "id": 457241226,
//            "album_id": -6,
//            "owner_id": 13717854,
//            "sizes": [
//                {
//                    "type": "m", (o,p,q,r,s,w,x,y,z)
//                    "url": "https://sun9-37.userapi.com/c849124/v849124679/1e80e5/kXcStfpXOfw.jpg",
//                    "width": 130,
//                    "height": 73
//                }
//            ],
//            "text": "",
//            "date": 1563617724,
//            "lat": 47.795484,
//            "long": 13.048581,
//            "post_id": 5815,
//            "likes": {
//                "user_likes": 0,
//                "count": 5
//            },
//            "reposts": {
//                "count": 0
//            }
//        },
