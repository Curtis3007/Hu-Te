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
           header["Http-Auth-Token"] = token
        }
        return header
    }
}

