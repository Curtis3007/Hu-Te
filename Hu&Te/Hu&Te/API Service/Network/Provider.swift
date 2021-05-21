//
//  Provider.swift
//  Hu&Te
//
//  Created by BigSur on 21/05/2021.
//

import Foundation

class Provider {
    static let shared = Provider()
    
    private let request: NetworkRequestProtocol = NetworkRequest()
    
    private var networkManager: APINetworkProtocol {
        return APINetwork(request: request)
    }
    
    var loginAPIService: LoginAPIServiceProtocol {
        return LoginAPIService(network: networkManager)
    }

}
