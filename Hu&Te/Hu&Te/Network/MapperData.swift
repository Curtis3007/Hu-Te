//
//  MapperData.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/30/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

struct MapperData {
    
    // MARK: MAP JSON OBJECT
    static func mapObject<T: BaseMappable>(_ successHandler: @escaping SuccessHandler<T>.object) -> NetworkJSONSuccess {
        return { baseResponse in
            let obj = Mapper<T>().map(JSONObject: baseResponse)
            successHandler(obj)
        }
    }
    
    static func mapObjectHasMetaData<T: BaseMappable>(_ successHandler: @escaping SuccessHandler<T>.object) -> NetworkJSONSuccess {
        return { baseResponse in
            let obj = Mapper<T>().map(JSONObject: baseResponse)
            successHandler(obj)
         }
    }
    
    static func mapArray<T: BaseMappable>(_ successHandler: @escaping SuccessHandler<T>.array) -> NetworkJSONSuccess {
        return { baseResponse in
            let obj = Mapper<T>().mapArray(JSONObject: baseResponse["data"])
            if let obj = obj {
                 successHandler(obj)
            } else {
                successHandler([])
            }
            
        }
    }
    
    static func mapArrayAdafruit<T: BaseMappable>(_ successHandler: @escaping SuccessHandler<T>.array) -> NetworkJSONAdafruitSuccess {
        return { baseResponse in
            let obj = Mapper<T>().mapArray(JSONObject: baseResponse)
            if let obj = obj {
                 successHandler(obj)
            } else {
                successHandler([])
            }
            
        }
    }
    
    static func mapArrayNoData<T: BaseMappable>(_ successHandler: @escaping SuccessHandler<T>.array) -> NetworkJSONSuccess {
        return { baseResponse in
            let obj = Mapper<T>().mapArray(JSONObject: baseResponse)
            if let obj = obj {
                 successHandler(obj)
            } else {
                successHandler([])
            }
            
        }
    }
}
