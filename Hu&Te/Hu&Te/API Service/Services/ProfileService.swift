//
//  ProfileService.swift
//  Hu&Te
//
//  Created by BigSur on 25/05/2021.
//
import Foundation

protocol ProfileAPIServiceProtocol {
    func getProfile(success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func updateProfile(name: String, phone: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func changePassword(id: String, currentPassword: String, newPassword: String, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure)
    
    func getUsers(success: @escaping SuccessHandler<UserListReturn>.object, failure: @escaping RequestFailure)
}

class ProfileAPIService: ProfileAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getProfile(success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = ProfileEndPoint.getProfile
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func updateProfile(name: String, phone: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = ProfileEndPoint.updateProfile(name: name, phone: phone)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func changePassword(id: String, currentPassword: String, newPassword: String, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = ProfileEndPoint.changePassword(id: id, currentPassword: currentPassword, newPassword: newPassword)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getUsers(success: @escaping SuccessHandler<UserListReturn>.object, failure: @escaping RequestFailure) {
        let endPoint = ProfileEndPoint.getUsers
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
