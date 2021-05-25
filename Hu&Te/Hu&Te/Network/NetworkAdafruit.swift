//
//  NetworkAdafruit.swift
//  Hu&Te
//
//  Created by BigSur on 24/05/2021.
//

import Foundation
import ObjectMapper
import SwiftyJSON
import Alamofire
import PKHUD
/***
 Input: endPoint (all info to request)
 Ouput: BaseResponse or error
 ***/

protocol APINetworkAdafruitProtocol {
    func requestData(endPoint: EndPointType, success: @escaping NetworkJSONAdafruitSuccess, failure: @escaping RequestFailure)
    func upload(endPoint: EndPointType, success: @escaping NetworkJSONAdafruitSuccess, failure: @escaping RequestFailure)
}

struct APINetworkAdafruit: APINetworkAdafruitProtocol {
    func upload(endPoint: EndPointType, success: @escaping NetworkJSONAdafruitSuccess, failure: @escaping RequestFailure) {
        
    }
    
    let request: NetworkRequestAdafruitProtocol
    
    init(request: NetworkRequestAdafruitProtocol) {
        self.request = request
    }

    func requestData(endPoint: EndPointType, success: @escaping NetworkJSONAdafruitSuccess, failure: @escaping RequestFailure) {
        print("URL: \(BASE_URL_ADAFRUIT)\(endPoint.path)")
        print(endPoint.parameters)
        if Reachability.isConnectedToNetwork() {
            request.requestData(endPoint: endPoint, success: { data in
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [AnyObject] {
                        print("*******************JSON Result************************")
                        print(json)
                        print("*******************END************************")
                        self.handleJSONResponse(response: json, success: success, failure: failure)
//                        if let status = json["status"] as? Int, status != 1 {
//                            let error = APIError(message: json["message"] as? String)
//                            failure(error)
//                        } else {
//                            self.handleJSONResponse(response: json, success: success, failure: failure)
//                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }) { error in
                if let _error = error {
                    if _error.message == "The Internet connection appears to be offline." {
                        let errorVC = UIAlertController.alertAcontroller(forError: APIError(message: "Unable to connect to the internet. Please check your connection and try again"))
                        errorVC.showErrorOnWindow()
                    } else {
                        print("APINetwork - requestData: \(String(describing: error?.message?.description))")
                    }
                    failure(APIError(error: error))
                }
            }
        } else {
            HUD.hide()
            let errorVC = UIAlertController.alertAcontroller(forError: APIError(message: "Internet Connection not Available!"))
            errorVC.showErrorOnWindow()
        }
    }
    
//    func upload(endPoint: EndPointType, success: @escaping NetworkJSONSuccess, failure: @escaping RequestFailure) {
//        if Reachability.isConnectedToNetwork() {
//            request.uploadImage(endPoint: endPoint, success: { data in
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [AnyObject] {
//                        print("*******************JSON Result************************")
//                        print(json)
//                        print("*******************END************************")
//                        self.handleJSONResponse(response: json, success: success, failure: failure)
////                        if json["message"] != nil {
////                            let error = APIError(message: json["message"] as? String)
////                            failure(error)
////                        } else {
////
////                        }
//                    }
//                } catch let error as NSError {
//                    print(error)
//                }
//            }){ error in
//                print("APINetwork - requestData: \(String(describing: error?.code?.description))")
//                failure(APIError(error: error))
//            }
//        } else {
//            HUD.hide()
//            let errorVC = UIAlertController.alertAcontroller(forError: APIError(message: "Internet Connection not Available!"))
//            errorVC.showErrorOnWindow()
//        }
//    }
}

// handle base response
extension APINetworkAdafruit {
    private func handleJSONResponse(response: [AnyObject], success: @escaping NetworkJSONAdafruitSuccess, failure: @escaping RequestFailure) {
        success(response)
    }
}
