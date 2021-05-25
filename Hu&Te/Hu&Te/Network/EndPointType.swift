//
//  EndPointType.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/27/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String: Any]

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: JSONDictionary { get }
    var headers: [String: String]? { get }
}

struct DefaultHeader {
    func addAuthHeader() -> [String: String] {
        var header: [String: String] = ["Content-Type": "application/json"]
        if let token = UserDefaultHelper.shared.accessToken {
           print("Token", token)
           header["auth-token"] = token
            
//        } else {
//            header["email"] = "admin@gmail.com"
//            header["password"] = "admin123"
//            print(header)
//        }
        }
        return header
    }
    
    func addAdafruitHeader() -> [String: String] {
        let header: [String: String] = ["Content-Type": "application/json"]
        return header
    }
    
    func addProfileHeader() -> [String: String] {
        var header: [String: String] = ["Content-Type": "application/json"]
        if let token = UserDefaultHelper.shared.accessToken, let id = UserDefaultHelper.shared.userId {
            header["auth-token"] = token
            header["id"] = id
//        } else {
//            header["email"] = "admin@gmail.com"
//            header["password"] = "admin123"
//            print(header)
//        }
        }
        return header
    }
}

