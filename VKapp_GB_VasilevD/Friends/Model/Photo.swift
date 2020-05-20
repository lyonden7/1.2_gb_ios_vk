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
    @objc dynamic var type = ""
    @objc dynamic var photoUrl = ""
//    var isLikedByUser = 0
//    var count = 0
    
    enum CodingKeys: String, CodingKey {
        case sizes = "sizes"
        case likes = "likes"
    }
    
    enum SizeKeys: String, CodingKey {
        case type = "type"
        case photoUrl = "url"
    }
    
//    enum LikesKeys: String, CodingKey {
//        case isLikedByUser = "user_likes"
//        case count = "count"
//    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let photoContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        var sizesContainer = try photoContainer.nestedUnkeyedContainer(forKey: .sizes)
        let sizesValues = try sizesContainer.nestedContainer(keyedBy: SizeKeys.self)
        
        self.type = try sizesValues.decode(String.self, forKey: .type)
        self.photoUrl = try sizesValues.decode(String.self, forKey: .photoUrl)
        
//        var likes = try photoValues.nestedUnkeyedContainer(forKey: .likes)
//        let likesValues = try likes.nestedContainer(keyedBy: LikesKeys.self)
//        self.isLikedByUser = try likesValues.decode(Int.self, forKey: .isLikedByUser)
//        self.count = try likesValues.decode(Int.self, forKey: .count)
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
