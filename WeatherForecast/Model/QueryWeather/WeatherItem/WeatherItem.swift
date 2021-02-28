//
//  WeatherItem.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct WeatherItem: Decodable, Hashable {
    let dt: Double
    let sunrise: Int
    let sunset: Int
    let temps: Temperature
    let feelsLikeTemps: FeelsLikeTemperature
    let pressure: Int
    let humidity: Int
    let weather: [Weather]
    let speed: Double
    let deg: Double
    let clouds: Double
    let pop: Double
    let rain: Double?
    
    private enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temps = "temp"
        case feelsLikeTemps = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case weather = "weather"
        case speed = "speed"
        case deg = "deg"
        case clouds = "clouds"
        case pop = "pop"
        case rain = "rain"
    }
}

extension WeatherItem {
    var date: Date {
        Date(timeIntervalSince1970: TimeInterval(dt))
    }
}
