//
//  Session.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 14/05/2020.
//  Copyright © 2020 Denis Vasilev. All rights reserved.
//

import Foundation

class Session {
    
    private init(){}
    
    static let instance = Session()
    
    
    
    var accessToken = String()
    var userID = Int()
    
}
