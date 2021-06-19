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
    case getThreshold
    case setThreshold(temp: String, humid: String)
    case deleteUser(id: String)
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
       case .getThreshold:
            return "/threshold"
       case .setThreshold:
            return "/threshold"
       case .deleteUser:
            return "/users"
       }
        
    
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getProfile , .getUsers, .getThreshold:
            return .get
        case .updateProfile, .setThreshold:
            return .put
        case .changePassword:
            return .post
        case .deleteUser:
            return .delete
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getProfile, .getUsers, .getThreshold, .deleteUser:
            return [:]
        case .updateProfile(name: let name, phone: let phone):
            return ["name" : name , "phone" : phone]
        case .changePassword(_, currentPassword: let currentPassword, newPassword: let newPassword):
            return ["curPassword" : currentPassword , "newPassword" : newPassword]
        case .setThreshold(temp: let temp, humid: let humid):
            return ["temp" : temp , "humid" : humid]
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getProfile, .updateProfile:
            return DefaultHeader().addProfileHeader()
        case .deleteUser(id: let id):
            return DefaultHeader().deleteHeader(id: id)
        default:
            return DefaultHeader().addAuthHeader()
        }
        
    }
    
}
