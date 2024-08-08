//
//  ApiServiceMock.swift
//  WeatherForecast
//
//  Created by httruc on 28/02/2021.
//

import Foundation
@testable import WeatherForecast

class ApiServiceMock: ApiServiceType {
    var queryWeatherResult: Result<QueryWeatherResponse, BaseError>?
    
    func queryWeather(
        at city: String,
        completion: @escaping (Result<QueryWeatherResponse, BaseError>) -> Void) {
        completion(queryWeatherResult ?? .failure(.unknown))
    }
}
