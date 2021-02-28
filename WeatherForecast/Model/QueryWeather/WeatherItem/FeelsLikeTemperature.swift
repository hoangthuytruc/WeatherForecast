//
//  FeelsLikeTemperature.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct FeelsLikeTemperature: Decodable, Hashable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
    
    private enum CodingKeys: String, CodingKey {
        case day = "day"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }
}
