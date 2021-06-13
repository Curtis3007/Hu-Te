//
//  NetworkRequestAdafruit.swift
//  Hu&Te
//
//  Created by BigSur on 24/05/2021.
//

import Alamofire

//#if PROD
//public var BASE_URL = URL(string: "https://makerspace-prod.vinova.sg/api")!
//public var BASE_URL_IMAGE = URL(string: "https://makerspace-prod.vinova.sg")!
//public var GOOGLE_SERVICE_FILE = ""
//#elseif DEV
//public var BASE_URL = URL(string: "https://makerspace-dev.vinova.sg/api")!
//public var BASE_URL_IMAGE = URL(string: "https://makerspace-dev.vinova.sg")!
////public var GOOGLE_SERVICE_FILE = "GoogleService-Info"
//#else
public var BASE_URL_ADAFRUIT = URL(string: "https://io.adafruit.com/api/v2/CSE_BBC/feeds")!
////public var BASE_URL_IMAGE = URL(string: "http://makerspace-123.vinova.sg")!
////public var GOOGLE_SERVICE_FILE = "GoogleService-Info"
////#endif
////---
//typealias RequestSuccess = (_ data: Data) -> Void
//typealias RequestFailure = (_ error: APIError?) -> Void
//
////---
//typealias NetworkJSONSuccess = (_ data: [String: AnyObject] ) -> Void
////---
//struct SuccessHandler<T> {
//    typealias object = (_ object: T?) -> Void
//    typealias array = (_ array: [T]) -> Void
//    typealias anyObject = (_ object: Any?) -> Void
//}

// NetworkPotocol
protocol NetworkRequestAdafruitProtocol {
    func requestData(endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure)
    func uploadImage(endPoint: EndPointType,success: @escaping RequestSuccess, failure: @escaping RequestFailure)
}

//---
struct NetworkRequestAdafruit: NetworkRequestAdafruitProtocol {
    static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 600 // seconds
        configuration.timeoutIntervalForResource = 600
        return configuration
    }()
    
    let manager: SessionManager = {
        return SessionManager(
            configuration: configuration
        )
    }()
    
    func requestData(endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {
        let url = makeUrl(path: endPoint.path)
        
        let encoding = getAlamofireEncoding(httpMethod: endPoint.httpMethod)
        
        let request = manager.request(url, method: endPoint.httpMethod, parameters: endPoint.parameters, encoding: encoding, headers: endPoint.headers)
        request.responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                let apiError = APIError(error: error)
                failure(apiError)
            }
        }
    }
    
    func uploadImage(endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {
        let url = makeUrl(path: endPoint.path)
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.upload(multipartFormData: { multipartFormData in
            for (key, value) in endPoint.parameters {
                if value is UIImage{
                    if let image = value as? UIImage, let data  = image.jpegData(compressionQuality: 0.2) {
                        let now = Int64(Date().timeIntervalSince1970 * 1000)
                        multipartFormData.append(data, withName: key, fileName: "\(key)\(now)", mimeType: "image/png")
                    }
                } else if value is [UIImage]{
                    
                    if let images = value as? [UIImage] {
                        for image in images {
                            if let data = image.jpegData(compressionQuality: 0.2) {
                                print("size of image and name:", Double(data.count), key)
                                multipartFormData.append(data, withName: key, fileName: "\(Date().timeIntervalSince1970).png", mimeType: "image/png")
                            }
                        }
                    }
                    
                } else if value is String || value is Int || value is Float || value is Double {
                    if let data = "\(value)".data(using: String.Encoding.utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                } else if value is [Int] {
                    if let data = value as? [Int] {
                        for valueArr in data{
                            if let dataArr = "\(valueArr)".data(using: String.Encoding.utf8) {
                                multipartFormData.append(dataArr, withName: key)
                            }
                        }
                    }
                } else if value is [String] {
                    if let data = value as? [String] {
                        for value in data{
                            if let codeData = value.data(using: String.Encoding.utf8) {
                                multipartFormData.append(codeData, withName: key)
                            }
                        }
                    }
                }
                else if value is [NYPNewStep]{
                    if let steps = value as? [NYPNewStep]{
                        for step in steps {
                            if let id = step.id{
                                multipartFormData.append("\(id)".data(using: String.Encoding.utf8)!, withName: "steps[][id]")
                                if let isDelete = step.isDelete{
                                    if isDelete{
                                        multipartFormData.append("1".data(using: String.Encoding.utf8)!, withName: "steps[][_destroy]")
                                    }
                                    else{
                                        multipartFormData.append("0".data(using: String.Encoding.utf8)!, withName: "steps[][_destroy]")
                                    }
                                }
                                else{
                                    multipartFormData.append("0".data(using: String.Encoding.utf8)!, withName: "steps[][_destroy]")
                                }
                            }
                            if let title = step.title{
                                multipartFormData.append(title.data(using: String.Encoding.utf8)!, withName: "steps[][title]")
                            }
                            if let number = step.number{
                                multipartFormData.append("\(number)".data(using: String.Encoding.utf8)!, withName: "steps[][number]")
                            }
                            if let descriptionStep = step.stepDescription{
                                multipartFormData.append(descriptionStep.data(using: String.Encoding.utf8)!, withName: "steps[][description]")
                            }
                            if let photos = step.photos{
                                if photos.count > 0{
                                    for photo in photos{
                                        if photo.id == nil{
                                        }
                                    }
                                }
                            }
                            if let photosDelete = step.photosDelete{
                                if photosDelete.count > 0{
                                    for photo in photosDelete{
                                        if let id = photo.id{
                                            multipartFormData.append("\(id)".data(using: String.Encoding.utf8)!, withName: "steps[][photos][][id]")
                                            multipartFormData.append("1".data(using: String.Encoding.utf8)!, withName: "steps[][photos][][_destroy]")
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
        }, to: url, method: endPoint.httpMethod, headers: endPoint.headers) { (encodingResult) in
            switch encodingResult {
            case .failure(let error):
                let apiError = APIError(error: error)
                failure(apiError)
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { progress in
                    let progress = Int(Double(progress.fractionCompleted) * 100)
                    print("\(progress)" + "%")
                })
                //                upload.responseString { (response) in
                //                    print(response)
                ////                    if let data = response.data {
                ////                        success(data)
                ////                    }
                //                    success(response.data!)
                //                }
                upload.responseJSON { (response) in
                    if let data = response.data {
                        success(data)
                    }
                }
            }
        }
    }
}

// MARK: helper NetworkRequest
extension NetworkRequestAdafruit {
    private func getAlamofireEncoding(httpMethod: HTTPMethod) -> ParameterEncoding {
        switch httpMethod {
        case .get:
            return URLEncoding.default
        case .post:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    private func makeUrl(path: String) -> String {
        return "\(BASE_URL_ADAFRUIT)\(path)"
    }
}

