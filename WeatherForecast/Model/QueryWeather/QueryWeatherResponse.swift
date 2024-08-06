//
//  QueryWeatherResponse.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct Wind: Decodable {
    let speed: Float
    let deg: Float
    let gust: Float?
    
    private enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
        case gust = "gust"
    }
}

struct Rain: Decodable {
    let hourly: Float
    
    private enum CodingKeys: String, CodingKey {
        case hourly = "1h"
    }
}

struct Clouds: Decodable {
    let all: Int
    
    private enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

struct Sys: Decodable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
    
    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}

struct QueryWeatherResponse: Decodable {
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let detail: WeatherItem
    let visibility: Int
    let wind: Wind
    let rain: Rain
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let cityId: Double
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
