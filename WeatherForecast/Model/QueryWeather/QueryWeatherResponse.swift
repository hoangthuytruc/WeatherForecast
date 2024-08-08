//
//  QueryWeatherResponse.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct QueryWeatherResponse: Decodable {
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let detail: WeatherDetail
    let visibility: Double
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let cityId: Int
    let cityName: String
    let cod: Int
    
    private enum CodingKeys: String, CodingKey {
        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case detail = "main"
        case visibility = "visibility"
        case wind = "wind"
        case rain = "rain"
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case timezone = "timezone"
        case cityId = "id"
        case cityName = "name"
        case cod = "cod"
    }
}

extension QueryWeatherResponse {
    var date: Date {
        Date(timeIntervalSince1970: TimeInterval(dt))
    }
}
