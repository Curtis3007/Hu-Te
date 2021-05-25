//
//  ProfileEndPoint.swift
//  Hu&Te
//
//  Created by BigSur on 24/05/2021.
//

import Alamofire

enum ProfileEndPoint {
    
    
    case getProfile
    case updateProfile(name: String, phone: String)
}

extension ProfileEndPoint: EndPointType {
    var path: String {
       switch self {
        
       case .getProfile:
            return "/users"
       case .updateProfile:
            return "/users"
       }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getProfile:
            return .get
        case .updateProfile:
            return .put
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getProfile:
            return [:]
        case .updateProfile(name: let name, phone: let phone):
            return ["name" : name , "phone" : phone]
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getProfile, .updateProfile:
            return DefaultHeader().addProfileHeader()
        default:
            return DefaultHeader().addAuthHeader()
        }
        
    }
    
}
