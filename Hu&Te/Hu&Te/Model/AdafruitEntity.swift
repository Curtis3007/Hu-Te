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
    
    var tempAndHumid: TemAndHumidEntity? {
        get {
            if let value = value {
                do {
                    let object = try JSONDecoder().decode(TemAndHumidEntity.self, from: value.data(using: .utf8)!)
                    return object
                } catch {
                    return nil
                }
            }
            return nil
        }
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



class TemAndHumidEntity: Codable {
    let id, name, data, unit: String?
    var temp: String? {
        get {
            if let data = data {
                let index = data.firstIndex(of: "-")
                return String(data.prefix(upTo: index!))
            }
            return nil
        }
    }
    
    var humid: String? {
        get {
            if let data = data {
                let index = data.firstIndex(of: "-")
                let temp = String(data.suffix(from: index!))
                return String(temp.dropFirst())
            }
            return nil
        }
    }

    init(id: String?, name: String?, data: String?, unit: String?) {
        self.id = id
        self.name = name
        self.data = data
        self.unit = unit
    }
}
