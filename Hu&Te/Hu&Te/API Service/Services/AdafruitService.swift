//
//  AdafruitService.swift
//  Hu&Te
//
//  Created by BigSur on 24/05/2021.
//

import Foundation

protocol AdafruitAPIServiceProtocol {
//    func loginStudent(adminNumber: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
//    func ssoLogin(email: String, jobTitle: String?, phoneNumber: String?, displayName: String?, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
//    func loginStaff(adminNumber: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
//    
//    func login(email: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func getTemperature(success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure)
    
    func getHumidity(success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure)
    
    func getTemAndHumid(success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure)
    
    func getValueFromTo(startTime: String, endTime: String, success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure)
    
    func getSpeaker(success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure)
    
    func setupSpeaker(data: Int, success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure)
}

class AdafruitAPIService: AdafruitAPIServiceProtocol {
    
    private let network: APINetworkAdafruitProtocol
    
    init(network: APINetworkAdafruitProtocol) {
        self.network = network
    }
    
    func getTemperature(success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = AdafruitEndPoint.getTemperature
        network.requestData(endPoint: endPoint, success: MapperData.mapArrayAdafruit(success), failure: failure)
    }
    
    func getHumidity(success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = AdafruitEndPoint.getHumidity
        network.requestData(endPoint: endPoint, success: MapperData.mapArrayAdafruit(success), failure: failure)
    }
    
    func getTemAndHumid(success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = AdafruitEndPoint.getTemAndHumid
        network.requestData(endPoint: endPoint, success: MapperData.mapArrayAdafruit(success), failure: failure)
    }
    
    func getValueFromTo(startTime: String, endTime: String, success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = AdafruitEndPoint.getValueFromTo(startTime: startTime, endTime: endTime)
        network.requestData(endPoint: endPoint, success: MapperData.mapArrayAdafruit(success), failure: failure)
    }
    
    func getSpeaker(success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = AdafruitEndPoint.getSpeaker
        network.requestData(endPoint: endPoint, success: MapperData.mapArrayAdafruit(success), failure: failure)
    }
    
    func setupSpeaker(data: Int, success: @escaping SuccessHandler<AdafruitEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = AdafruitEndPoint.setSpeaker(data: data)
        network.requestData(endPoint: endPoint, success: MapperData.mapArrayAdafruit(success), failure: failure)
    }
}
