//
//  Sys.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation

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
