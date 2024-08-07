//
//  Coordinate.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct Coordinate: Decodable, Hashable {
    let long: Double
    let lat: Double
    
    private enum CodingKeys: String, CodingKey {
        case long = "lon"
        case lat = "lat"
    }
}
