//
//  AdafruitEntity.swift
//  Hu&Te
//
//  Created by BigSur on 24/05/2021.
//

import Foundation
import ObjectMapper

class AdafruitEntity: Mappable {
    var id, value: String?
    var feedID: Int?
    var feedKey: String?
    var createdAt: Date?
    var createdEpoch: Int?
    var expiration: Date?
    
    init() {}
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.value <- map["value"]
        self.feedID <- map["feed_id"]
        self.feedKey <- map["feed_key"]
        self.createdAt <- map["created_at"]
        self.createdEpoch <- map["created_epoch"]
        self.expiration <- map["expiration"]
    }
}

