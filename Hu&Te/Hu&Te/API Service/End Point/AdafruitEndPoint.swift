//
//  AdafruitEndPoint.swift
//  Hu&Te
//
//  Created by BigSur on 24/05/2021.
//

import Alamofire

enum AdafruitEndPoint {
    
    
    case getTemperature
    case getHumidity
    case getTemAndHumid
    case getValueFromTo(startTime: String, endTime: String)
    case setSpeaker(data: Int)
}

extension AdafruitEndPoint: EndPointType {
    var path: String {
       switch self {
       case .getTemperature:
            return "/bk-iot-temp/data"
       case .getHumidity:
            return "/bk-iot-humid/data?limit=1"
       case .getTemAndHumid:
            return "/bk-iot-temp-humid/data?limit=1"
       case .getValueFromTo:
            return "/bk-iot-temp-humid/data"
       case .setSpeaker:
            return "/bk-iot-speaker/data"
       }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getHumidity, .getTemperature, .getTemAndHumid, .getValueFromTo:
            return .get
        case .setSpeaker:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getHumidity, .getTemperature, .getTemAndHumid:
            return [:]
        case .getValueFromTo(startTime: let startTime, endTime: let endTime):
            return ["start_time" : startTime, "end_time" : endTime]
        case .setSpeaker(data: let data):
            return ["value":"{\"id\" : \"2\", \"name\" : \"SPEAKER\", \"data\": \"\(data)\", \"unit\" : \"\"}"]
        }
    }
    
    var headers: [String : String]? {
        return DefaultHeader().addAdafruitHeader()
    }
    
}
