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
    
    func loadFriends(token: String){
        let path  = "friends.get"
        let url = baseURL + path
        let parameters: Parameters = [
            "access_token": token,
            "v": versionAPI,
            "fields": "photo_50",
            "order": "hints"
        ]
        
        NetworkService.session.request(url, parameters: parameters).responseJSON { response in
            guard let json = response.value else { return }
            print(json)
        }
    }
    
    func loadFriendPhotos(token: String){
        let path  = "photos.getAll"
        let url = baseURL + path
        let parameters: Parameters = [
            "access_token": token,
            "v": versionAPI,
            "extended": 1
        ]
        
        NetworkService.session.request(url, parameters: parameters).responseJSON { response in
            guard let json = response.value else { return }
            print(json)
        }
    }
    
    func loadGroups(token: String){
        let path  = "groups.get"
        let url = baseURL + path
        let parameters: Parameters = [
            "access_token": token,
            "v": versionAPI,
            "extended": 1
        ]
        
        NetworkService.session.request(url, parameters: parameters).responseJSON { response in
            guard let json = response.value else { return }
            print(json)
        }
    }
    
    func loadSearchGroups(token: String){
        let path  = "groups.search"
        let url = baseURL + path
        let parameters: Parameters = [
            "access_token": token,
            "v": versionAPI,
            "q": "troitsk"
        ]
        
        NetworkService.session.request(url, parameters: parameters).responseJSON { response in
            guard let json = response.value else { return }
            print(json)
        }
    }
}
