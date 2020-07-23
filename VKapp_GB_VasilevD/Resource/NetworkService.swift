//
//  NetworkService.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 17/05/2020.
//  Copyright © 2020 Denis Vasilev. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class NetworkService {
    static let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    let baseURL = "https://api.vk.com/method/"
    let versionAPI = "5.103"
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func loadFriends(completion: @escaping () -> Void){
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
            let friend = try! JSONDecoder().decode(FriendResponse.self, from: data).response.items
            self.saveFriendsData(friend)
            completion()
        }
    }
    
    func saveFriendsData (_ friends: [Friend]) {
        do {
//            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//            let realm = try Realm(configuration: config)
            let realm = try Realm()
            print(realm.configuration.fileURL)
            let oldFriends = realm.objects(Friend.self)
            realm.beginWrite()
            realm.delete(oldFriends)
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func loadFriendPhotos(ownerId: Int, completion: @escaping () -> Void){
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
                let photo = try JSONDecoder().decode(PhotoResponse.self, from: data).response.items
                self.saveFriendPhotosData(photo, ownerId: ownerId)
                completion()
            } catch {
                print(error)
            }
        }
    }
    
    func saveFriendPhotosData (_ photos: [Photo], ownerId: Int) {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL)
            let filter = "ownerId == " + String(ownerId)
            let oldPhotos = realm.objects(Photo.self).filter(filter)
            realm.beginWrite()
            realm.delete(oldPhotos)
            realm.add(photos)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func loadGroups(completion: @escaping () -> Void){
        let path  = "groups.get"
        let url = baseURL + path
        let parameters: Parameters = [
            "access_token": token,
            "v": versionAPI,
            "extended": 1
        ]
        
        NetworkService.session.request(url, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let group = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
            self.saveGroupsData(group)
            completion()
        }
    }
    
    func saveGroupsData (_ groups: [Group]) {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL)
            let oldGroups = realm.objects(Group.self)
            realm.beginWrite()
            realm.delete(oldGroups)
            realm.add(groups)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func loadSearchGroups(for searchTtext: String, completion: @escaping ([Group]) -> Void){
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
//            do {
//                let group = try JSONDecoder().decode(GroupResponse.self, from: data).response
//                completion(group.items)
//                print(group)
//            } catch {
//                print(error)
//            }
            
        }
    }
}
