//
//  SectionsNetworkService.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

protocol SectionsNetworkServiceProtocol {
    var accessToApiService: AccessToApiServiceProtocol { get }
    func fetchSections(completion: @escaping OptionalItemClosureWithError<ResponceSections>)
}

class SectionsNetworkService: BasicNetworkService, SectionsNetworkServiceProtocol {
    var accessToApiService: AccessToApiServiceProtocol = AccessToApiService()
    
    func fetchSections(completion: @escaping OptionalItemClosureWithError<ResponceSections>) {
        let endPointSections = EndPoint.sections
        var url = NetworkServiceURL(endPoint: endPointSections)
        let apiKey = accessToApiService.getApiKey()
        let parameters = [
            apiKey.keyID: apiKey.keyValue
        ]
        url.setParameters(parameters: parameters)
        request(url: url) { data, error in
            guard error == nil else { return completion(nil, error)}
            if let json = data {
                let responceSections = ResponceSections(json: json)
                completion(responceSections, nil)
            } else {
                let error = ApplicationError(description: "SectionsServiceError ERROR: mapping fault")
                completion(nil, error)
            }
        }
    }
}
