//
//  BaseResponse.swift
//  Cihyn_Dev
//
//  Created by Ngoc Duong on 9/28/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import ObjectMapper

// Base
class BaseResponse: Mappable {
    var code: Int?
    var status: Bool?
    var message: String?
    var data: Any?
    var metaData: Any?
    var error: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        status      <- map["status"]
        message     <- map["message"]
        data        <- map["data"]
        code        <- map["code"]
        metaData <- map["metadata"]
        error <- map["error"]
    }
}
