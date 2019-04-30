//
//  BasicNetworkService.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BasicNetworkService {
    internal func request(url: NetworkServiceURLProtocol, completion: @escaping OptionalItemClosureWithError<JSON>) {
        guard let sourseUrl = url.sourseUrl else {
            let error = ApplicationError(description: "BasicService ERROR: sourse url = nil")
            completion(nil,error)
            return
        }
        
        Alamofire.request(sourseUrl,
                          method: url.httpMethod,
                          parameters: url.parameters,
                          encoding: url.encoding,
                          headers: url.headers)
            .responseJSON { data in
                switch data.result {
                case .success(let value):
                    let json = JSON(value)
                    completion(json, nil)
                    break
                case .failure(let error):
                    completion(nil, error)
                    break
                }
        }
    }
}
