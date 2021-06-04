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
    var createdAt: String?
    var createdEpoch: Int?
    var expiration: Date?
    
    init() {}
    
    required init?(map: Map) {
    }
    
    var timeInDay: Int {
        get {
            if let createdEpoch = createdEpoch {
                let date = Date()
                let iso8601DateFormatter = ISO8601DateFormatter()
                iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                let now = iso8601DateFormatter.string(from: date)
                let startTime = String(now.prefix(11)) + "00:00:00Z"
                let dateTime = startTime.convertToDate()
                let timeMidNight = Int(dateTime.timeIntervalSince1970)
                print("TimeToDay: \(timeMidNight)")
                return (createdEpoch - timeMidNight) / 60
            }
            return 0
        }
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
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let dateStr = createdAt?.components(separatedBy: "T").first, let date = dateFormatter.date(from: dateStr) {
            return date.toDayStringBlueSky()
        } else {
            return ""
        }
    }
    
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let dateStr = createdAt?.components(separatedBy: "T").last, let _dateTime = dateFormatter.date(from: subString(str: dateStr)){
            return "\(_dateTime.toTimeString())"
        } else {
            return ""
        }
    }
    
    func subString(str: String) -> String {
        let startIndex = str.index(str.startIndex, offsetBy: 0)
        let endIndex = str.index(str.startIndex, offsetBy: 4)
        let temp = String(str[startIndex...endIndex])
        return temp
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
