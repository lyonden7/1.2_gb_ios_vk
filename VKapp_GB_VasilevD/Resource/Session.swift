//
//  Session.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 14/05/2020.
//  Copyright © 2020 Denis Vasilev. All rights reserved.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    private init(){}
    
    var accessToken = String()
    var userID = Int()
    
}
