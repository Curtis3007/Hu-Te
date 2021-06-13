//
//  BaseEntity.swift
//  Hu&Te
//
//  Created by BigSur on 25/05/2021.
//

import Foundation
import ObjectMapper

class BaseEntity: Mappable {
    
    var status: String?
    var error: String?
    
    init() {}
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.status <- map["status"]
        self.error <- map["error"]
    }
}
