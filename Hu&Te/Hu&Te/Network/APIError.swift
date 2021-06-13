//
//  APIError.swift
//  Cihyn_Dev
//
//  Created by Ngoc Duong on 9/28/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit
import ObjectMapper
// MARK APPError
struct ResponseData {
    let data: Data
}
struct APPError {
    static let canNotParseData = APIError(message: "Can Not Parse Data")
}

// MARK: APIError class
class APIError: Error {
    let code: Int?
    let message: String?
    var data: Any? = nil
    let error: String? = nil
    
    init(code: Int?, message: String?) {
        self.code = code
        self.message = message
    }
    
    init(message: String?) {
        self.message = message
        self.code = nil
    }
    
    init(baseResponse: BaseResponse) {
        self.code = baseResponse.code
        self.message = baseResponse.message
        self.data = baseResponse.data
    }
    
    init(error: Error?) {
        self.code = nil
        self.message = error?.localizedDescription
    }
    
    init?(response: ResponseData) {
        do {
            if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? JSONDictionary {
                let status = json["status"] as? Bool
                guard let _status = status else { return nil }
                if _status {
                    return nil
                } else {
                    let responseError = Mapper<BaseResponse>().map(JSONObject: json)
                    guard let _responseError = responseError else { return nil }
                    self.code = _responseError.code ?? 0
                    self.message = _responseError.message ?? ""
                }
            } else {
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }
}

