//
//  AccessToApiService.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 30.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

protocol AccessToApiServiceProtocol {
    func getApiKey() -> ApiKey
}

class AccessToApiService: AccessToApiServiceProtocol {
    func getApiKey() -> ApiKey {
        return ApiKey(keyID: "api-key", keyValue: "388209e4-98c9-43a6-ab48-6a5098feaf37")
    }
}

struct ApiKey {
    let keyID: String
    let keyValue: String
}
