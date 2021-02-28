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

enum Helper {
    private static func getDataMock(fileData: String) -> Data {
        let dataUrl = Bundle.main.url(
            forResource: fileData,
            withExtension: "json")!
        let data = try! Data(contentsOf: dataUrl)
        return data
    }

    static func getQueryWeatherResponse(at city: String) -> QueryWeatherResponse {
        let data = getDataMock(fileData: "\(city)_weather")
        let object = try! JSONDecoder().decode(QueryWeatherResponse.self, from: data)
        return object
    }
}


