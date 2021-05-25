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
    private let requestAdafruit: NetworkRequestAdafruitProtocol = NetworkRequestAdafruit()
    
    private var networkManager: APINetworkProtocol {
        return APINetwork(request: request)
    }
    
    private var networkManagerAdafruit: APINetworkAdafruitProtocol {
        return APINetworkAdafruit(request: requestAdafruit)
    }
    
    var loginAPIService: LoginAPIServiceProtocol {
        return LoginAPIService(network: networkManager)
    }
    
    var adafruitAPIService: AdafruitAPIServiceProtocol {
        return AdafruitAPIService(network: networkManagerAdafruit)
    }

}
