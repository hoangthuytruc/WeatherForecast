//
//  Wind.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
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
