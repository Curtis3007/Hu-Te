//
//  AuthenEndPoint.swift
//  Hu&Te
//
//  Created by BigSur on 21/05/2021.
//

import Alamofire

enum LoginEndPoint {
    case login(String, String)
    case register(name: String, email: String, phone: String, password: String)
}

extension LoginEndPoint: EndPointType {
    var path: String {
       switch self {
        case .login:
            return "/user/login"
        case .register:
            return "/user/register"
       }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .register(name: let name, email: let email, phone: let phone, password: let password):
            return ["name" : name, "email": email, "phone" : phone, "password" : password]
        case .login(let email, let password):
            return ["email" : email , "password" : password]
        }
    }
    
    var headers: [String : String]? {
        return DefaultHeader().addAuthHeader()
    }
    
}
