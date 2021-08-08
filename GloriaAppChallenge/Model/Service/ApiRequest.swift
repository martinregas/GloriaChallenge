//
//  ApiRequest.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 22/07/2021.
//

import UIKit

enum HTTPMethods: String {
    case get, post, put, delete
}

struct ApiRequest {
    let path:ApiRequestPath
    let method: HTTPMethods
    let parameters: [String:Any]?
    
    init(path:ApiRequestPath, method: HTTPMethods, parameters: [String:Any]? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
    }
}
