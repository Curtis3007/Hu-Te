//
//  Network.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/27/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//
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

protocol APINetworkProtocol {
    func requestData(endPoint: EndPointType, success: @escaping NetworkJSONSuccess, failure: @escaping RequestFailure)
    func upload(endPoint: EndPointType, success: @escaping NetworkJSONSuccess, failure: @escaping RequestFailure)
}

struct APINetwork: APINetworkProtocol {
    let request: NetworkRequestProtocol
    
    init(request: NetworkRequestProtocol) {
        self.request = request
    }

    func requestData(endPoint: EndPointType, success: @escaping NetworkJSONSuccess, failure: @escaping RequestFailure) {
        print("URL: \(BASE_URL)\(endPoint.path)")
        print(endPoint.parameters)
        if Reachability.isConnectedToNetwork() {
            request.requestData(endPoint: endPoint, success: { data in
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: AnyObject] {
                        print("*******************JSON Result************************")
                        print(json)
                        print("*******************END************************")
                        if let status = json["status"] as? Int, status != 1 {
                            let error = APIError(message: json["message"] as? String)
                            failure(error)
                        } else {
                            self.handleJSONResponse(response: json, success: success, failure: failure)
                        }
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
    func upload(endPoint: EndPointType, success: @escaping NetworkJSONSuccess, failure: @escaping RequestFailure) {
        if Reachability.isConnectedToNetwork() {
            request.uploadImage(endPoint: endPoint, success: { data in
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: AnyObject] {
                        print("*******************JSON Result************************")
                        print(json)
                        print("*******************END************************")
                        if json["message"] != nil {
                            let error = APIError(message: json["message"] as? String)
                            failure(error)
                        } else {
                            self.handleJSONResponse(response: json, success: success, failure: failure)
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }){ error in
                print("APINetwork - requestData: \(String(describing: error?.code?.description))")
                failure(APIError(error: error))
            }
        } else {
            HUD.hide()
            let errorVC = UIAlertController.alertAcontroller(forError: APIError(message: "Internet Connection not Available!"))
            errorVC.showErrorOnWindow()
        }
    }
}

// handle base response
extension APINetwork {
    private func handleJSONResponse(response: [String: AnyObject], success: @escaping NetworkJSONSuccess, failure: @escaping RequestFailure) {
        success(response)
    }
}
