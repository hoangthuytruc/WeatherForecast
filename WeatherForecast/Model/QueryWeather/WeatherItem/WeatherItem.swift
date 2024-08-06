//
//  WeatherItem.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct WeatherItem: Decodable, Hashable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let feelsLikes: Double
    let pressure: Int
    let humidity: Int
    let seaLevel: Int
    let grndLevel: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLikes = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}
