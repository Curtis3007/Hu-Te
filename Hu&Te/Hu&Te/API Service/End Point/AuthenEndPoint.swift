//
//  AuthenEndPoint.swift
//  Hu&Te
//
//  Created by BigSur on 21/05/2021.
//

import Alamofire

enum LoginEndPoint {
    case loginStudent(String, String)
    case loginStaff(String, String)
    case ssoLogin(String, String, String?, String?)
    case login(String, String)
    case register(name: String, email: String, phone: String, password: String)
}

extension LoginEndPoint: EndPointType {
    var path: String {
       switch self {
        case .loginStudent(_, _):
            return "/v1/auth/student/"
        case .loginStaff(_, _):
            return "/v1/auth/staff/"
        case .ssoLogin:
            return "/v1/auth"
        case .login(_, _):
            return "/user/login"
       case .register:
            return "/user/register"
       }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .loginStudent(_, _), .loginStaff(_, _),.ssoLogin(_, _, _, _):
            return .post
        case .login, .register:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .loginStaff(let adminNumber, let password):
            return  ["admin_number" : adminNumber , "password" : password]
        case .loginStudent(let adminNumber, let password):
            return ["admin_number" : adminNumber , "password" : password ]
        case .ssoLogin(let email, let jobTitle, let phoneNumber, let displayName):
            return ["email": email, "job_title": jobTitle, "phone_number": phoneNumber ?? "", "display_name": displayName ?? ""]
        case .register:
            return [:]
        case .login(let email, let password):
            return ["email" : email , "password" : password]
        }
    }
    
    var headers: [String : String]? {
        return DefaultHeader().addAuthHeader()
    }
    
}
