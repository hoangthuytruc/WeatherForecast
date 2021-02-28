//
//  Temperature.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct Temperature: Decodable, Hashable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
    
    private enum CodingKeys: String, CodingKey {
        case day = "day"
        case min = "min"
        case max = "max"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }
}
