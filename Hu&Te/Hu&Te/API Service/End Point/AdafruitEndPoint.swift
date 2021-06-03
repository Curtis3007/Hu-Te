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
       }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getHumidity, .getTemperature, .getTemAndHumid:
            return .get
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getHumidity, .getTemperature, .getTemAndHumid:
            return [:]
        }
    }
    
    var headers: [String : String]? {
        return DefaultHeader().addAdafruitHeader()
    }
    
}

