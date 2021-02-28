//
//  ApiServiceImpl.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

extension ApiService: ApiServiceType {
    static let shared = ApiService(host: "api.openweathermap.org")
    
    func queryWeather(
        at city: String,
        completion: @escaping (Result<QueryWeatherResponse, BaseError>) -> Void) {
        
        let request = RequestFactory.queryWeather(at: city)
        let httpRequest = HTTPRequest(
            httpMethod: .get,
            path: Endpoint.queryWeather,
            params: request.asParams()
        )
        fetch(request: httpRequest) { (result: Result<QueryWeatherResponse, BaseError>) in
            switch result {
            case .success(let response):
                completion(.success(response))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
