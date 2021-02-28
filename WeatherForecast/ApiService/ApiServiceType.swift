//
//  ApiServiceType.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

protocol ApiServiceType {
    func queryWeather(
        at city: String,
        completion: @escaping (Result<QueryWeatherResponse, BaseError>) -> Void
    )
}
