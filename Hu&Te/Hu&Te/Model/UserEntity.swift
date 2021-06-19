//
//  UserEntity.swift
//  Hu&Te
//
//  Created by BigSur on 21/05/2021.
//

import Foundation
import ObjectMapper

class UserEntity: Mappable {
    var isAdmin: Int?
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
        self.isAdmin <- map["isAdmin"]
        self.createdAt <- map["created_at"]
        self.id <- map["_id"]
        self.name <- map["name"]
        self.email <- map["email"]
        self.phone <- map["phone"]
        self.token <- map["token"]
        self.error <- map["error"]
    }
}

class ThresholdEntity: Mappable {
    var id: String?
    var error: String?
    var temp: String?
    var humid: String?
    var speakerFreq: Int?
    
    init() {}
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["_id"]
        self.temp <- map["temp"]
        self.humid <- map["humid"]
        self.speakerFreq <- map["speakerFreq"]
        self.error <- map["error"]
    }
}

class UserListReturn: Mappable {
    var users: [UserEntity]?
    var error: String?
    
    init() {}
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.users <- map["users"]
        self.error <- map["error"]
    }
}

