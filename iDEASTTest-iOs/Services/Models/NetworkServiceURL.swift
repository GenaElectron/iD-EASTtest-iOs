//
//  NetworkServiceURL.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkServiceURLProtocol {
    var host: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var sourseUrl: URL? { get }
    var encoding: ParameterEncoding { get }
    init (endPoint: EndPointProtocol)
    mutating func setHeaders (headers: HTTPHeaders)
    mutating func setParameters (parameters: Parameters)
}

struct NetworkServiceURL: NetworkServiceURLProtocol {
    private var endPoint: EndPointProtocol
    private var soursePath: String {
        return self.host + self.endPoint.path
    }
    var httpMethod: HTTPMethod {
        return self.endPoint.httpMethod
    }
    var encoding: ParameterEncoding {
        return self.endPoint.encoding
    }
    init(endPoint: EndPointProtocol) {
        self.endPoint = endPoint
    }
    var host: String {
       return "https://content.guardianapis.com"
    }    
    var sourseUrl: URL? {
        return URL(string: soursePath)
    }
    var headers: HTTPHeaders?
    var parameters: Parameters?
    
    mutating func setHeaders(headers: HTTPHeaders) {
        self.headers = headers
    }
    mutating func setParameters(parameters: Parameters) {
        self.parameters = parameters
    }
}

protocol EndPointProtocol {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}

enum EndPoint: EndPointProtocol {
    case sections
    case section(_ id: String)
    var path: String {
        switch self {
        case .sections: return "/sections"
            
        case .section(let id):
            return "/" + id
        }
    }
    var httpMethod: HTTPMethod {
        switch self {
        default: return .get
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
}
