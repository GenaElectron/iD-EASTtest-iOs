//
//  SectionContentNetworkService.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

protocol SectionContentNetworkServiceProtocol {
    var accessToApiService: AccessToApiServiceProtocol { get }
    func fetchSectionContent(section: Section, page: Int, pageSize: Int, completion: @escaping OptionalItemClosureWithError<ResponceSectionContent>)
}

class SectionContentNetworkService: BasicNetworkService, SectionContentNetworkServiceProtocol {
    var accessToApiService: AccessToApiServiceProtocol = AccessToApiService()
    
    func fetchSectionContent(section: Section, page: Int, pageSize: Int, completion: @escaping OptionalItemClosureWithError<ResponceSectionContent>) {
        guard let id = section.id else {
            let error = ApplicationError(description: "SectionContentNetworkService ERROR: section id is nil")
            completion(nil, error)
            return
        }
        guard page >= 1, pageSize >= 1 else {
            let error = ApplicationError(description: "SectionContentNetworkService ERROR: page or pageSize value < 1")
            completion(nil, error)
            return
        }
        let endPoint = EndPoint.section(id)
        var url = NetworkServiceURL(endPoint: endPoint)
        let apiKey = accessToApiService.getApiKey()
        let parameters = [
            "page":"\(page)",
            "page-size":"\(pageSize)",
            apiKey.keyID: apiKey.keyValue
            ]
        url.setParameters(parameters: parameters)
        request(url: url) { data, error in
            guard error == nil else { return completion(nil, error)}
                if let json = data{
                    let responceSectionContent = ResponceSectionContent(json: json)
                    completion(responceSectionContent, nil)
                } else {
                    let error = ApplicationError(description: "SectionContentNetworkService ERROR: JSON is nil")
                    completion(nil, error)
                }
        }
    }
}
