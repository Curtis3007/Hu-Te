//
//  AuthenService.swift
//  Hu&Te
//
//  Created by BigSur on 21/05/2021.
//
import Foundation

protocol LoginAPIServiceProtocol {
    func loginStudent(adminNumber: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    func ssoLogin(email: String, jobTitle: String?, phoneNumber: String?, displayName: String?, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    func loginStaff(adminNumber: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func login(email: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) 
}

class LoginAPIService: LoginAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func loginStudent(adminNumber: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = LoginEndPoint.loginStudent(adminNumber, password)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func ssoLogin(email: String, jobTitle: String?, phoneNumber: String?, displayName: String?, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = LoginEndPoint.ssoLogin(email, jobTitle ?? "", phoneNumber, displayName)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loginStaff(adminNumber: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = LoginEndPoint.loginStaff(adminNumber, password)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func login(email: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = LoginEndPoint.login(email, password)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func register(name: String, email: String, phone: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = LoginEndPoint.login(email, password)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
}
