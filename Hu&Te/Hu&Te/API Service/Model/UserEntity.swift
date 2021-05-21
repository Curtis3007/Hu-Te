//
//  UserEntity.swift
//  Hu&Te
//
//  Created by BigSur on 21/05/2021.
//

import Foundation
import ObjectMapper

class UserEntity: Mappable {
    var isAdmin: Bool!
    var createdAt: String?
    var id: String?
    var name : String?
    var email : String?
    var phone: String?
    var token: String?
    var error: String?
    
    init() {}
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.isAdmin <- map["is_admin"]
        self.createdAt <- map["created_at"]
        self.id <- map["_id"]
        self.name <- map["name"]
        self.email <- map["email"]
        self.phone <- map["phone"]
        self.token <- map["token"]
        self.error <- map["error"]
    }
}

