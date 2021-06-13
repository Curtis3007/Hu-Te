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
    case changePassword(id: String, currentPassword: String, newPassword: String)
    case getUsers
}

extension ProfileEndPoint: EndPointType {
    
    var path: String {
       switch self {
       case .getProfile:
            return "/users"
       case .updateProfile:
            return "/users"
       case .changePassword(id: let id, _, _):
            return "/profile/password?id=\(id)"
       case .getUsers:
            return "/users"
       }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getProfile , .getUsers:
            return .get
        case .updateProfile:
            return .put
        case .changePassword:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getProfile, .getUsers:
            return [:]
        case .updateProfile(name: let name, phone: let phone):
            return ["name" : name , "phone" : phone]
        case .changePassword(_, currentPassword: let currentPassword, newPassword: let newPassword):
            return ["curPassword" : currentPassword , "newPassword" : newPassword]
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
