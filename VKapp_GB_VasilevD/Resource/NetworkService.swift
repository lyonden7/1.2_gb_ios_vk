//
//  NetworkService.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 17/05/2020.
//  Copyright © 2020 Denis Vasilev. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    static let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    let baseURL = "https://api.vk.com/method/"
    let versionAPI = "5.103"
    
    func loadFriends(token: String, completion: @escaping ([Friend]) -> Void){
        let path  = "friends.get"
        let url = baseURL + path
        let parameters: Parameters = [
            "access_token": token,
            "v": versionAPI,
            "fields": "photo_50",
            "order": "hints"
        ]
        
        NetworkService.session.request(url, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let friend = try! JSONDecoder().decode(FriendResponse.self, from: data).response
            completion(friend.items)
        }
    }
    
    func loadFriendPhotos(token: String, ownerId: Int, completion: @escaping ([Photo]) -> Void){
        let path  = "photos.getAll"
        let url = baseURL + path
        let parameters: Parameters = [
            "access_token": token,
            "v": versionAPI,
            "extended": 1,
            "owner_id": ownerId,
            "count": 200
        ]
        
        NetworkService.session.request(url, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let photo = try JSONDecoder().decode(PhotoResponse.self, from: data).response
                completion(photo.items)
                print(photo)
            } catch {
                print(error)
            }
        }
    }
    
    func loadGroups(token: String, completion: @escaping ([Group]) -> Void){
        let path  = "groups.get"
        let url = baseURL + path
        let parameters: Parameters = [
            "access_token": token,
            "v": versionAPI,
            "extended": 1
        ]
        
        NetworkService.session.request(url, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let group = try! JSONDecoder().decode(GroupResponse.self, from: data).response
            completion(group.items)
            print(group)
        }
    }
    
    func loadSearchGroups(token: String, for searchTtext: String, completion: @escaping ([Group]) -> Void){
        let path  = "groups.search"
        let url = baseURL + path
        let parameters: Parameters = [
            "access_token": token,
            "v": versionAPI,
            "q": searchTtext
        ]
        
        NetworkService.session.request(url, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let group = try! JSONDecoder().decode(GroupResponse.self, from: data).response
            completion(group.items)
            print(group)
        }
    }
}
