//
//  Clouds.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation

struct Clouds: Decodable {
    let all: Double
    
    private enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}
