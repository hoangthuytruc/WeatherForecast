//
//  Rain.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation

struct Rain: Decodable {
    let lastHour: Double
    
    private enum CodingKeys: String, CodingKey {
        case lastHour = "1h"
    }
}
