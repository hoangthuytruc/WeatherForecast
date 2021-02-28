//
//  QueryWeatherResponse.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct QueryWeatherResponse: Decodable {
    let cod: String
    let message: Double
    let cnt: Int
    let city: City
    let weatherItems: [WeatherItem]
    
    private enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case city = "city"
        case weatherItems = "list"
    }
}
