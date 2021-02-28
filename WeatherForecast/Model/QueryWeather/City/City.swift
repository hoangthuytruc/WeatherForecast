//
//  City.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct City: Decodable, Hashable {
    let id: Double
    let name: String
    let coord: Coordinate
    let country: String
    let population: Double
    let timeZoneBySeconds: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case coord = "coord"
        case country = "country"
        case population = "population"
        case timeZoneBySeconds = "timezone"
    }
}

extension City {
    var timeZone: TimeZone? {
        TimeZone(secondsFromGMT: timeZoneBySeconds)
    }
}
