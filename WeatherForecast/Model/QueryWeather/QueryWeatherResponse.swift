//
//  QueryWeatherResponse.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct Wind: Decodable {
    let speed: Double
    let deg: Double
    let gust: Double?
    
    private enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
        case gust = "gust"
    }
}

struct Rain: Decodable {
    let lastHour: Double
    
    private enum CodingKeys: String, CodingKey {
        case lastHour = "1h"
    }
}

struct Clouds: Decodable {
    let all: Double
    
    private enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

struct Sys: Decodable {
    let type: Int
    let id: Int
    let country: String
    private let sunriseTimeInterval: Int
    private let sunsetTimeInternal: Int
    
    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case country = "country"
        case sunriseTimeInterval = "sunrise"
        case sunsetTimeInternal = "sunset"
    }
}

extension Sys {
    var sunrise: Date {
        Date(timeIntervalSince1970: TimeInterval(sunriseTimeInterval))
    }
    var sunset: Date {
        Date(timeIntervalSince1970: TimeInterval(sunsetTimeInternal))
    }
}

struct QueryWeatherResponse: Decodable {
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let detail: WeatherItem
    let visibility: Double
    let wind: Wind
    let rain: Rain?
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
