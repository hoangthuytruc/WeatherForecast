//
//  HTTPRequest.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct HTTPRequest {
    let httpMethod: HTTPMethod
    let path: String
    let params: [String: String]?
    let body: BaseRequest?
    
    internal init(
        httpMethod: HTTPMethod,
        path: String,
        params: [String : String]? = nil,
        body: BaseRequest? = nil) {
        
        self.httpMethod = httpMethod
        self.path = path
        self.params = params
        self.body = body
    }
}
