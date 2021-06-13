//
//  AuthenService.swift
//  Hu&Te
//
//  Created by BigSur on 21/05/2021.
//
import Foundation

protocol LoginAPIServiceProtocol {
    func login(email: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func register(name: String, email: String, phone: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
}

class LoginAPIService: LoginAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func login(email: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = LoginEndPoint.login(email, password)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func register(name: String, email: String, phone: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = LoginEndPoint.register(name: name, email: email, phone: phone, password: password)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
