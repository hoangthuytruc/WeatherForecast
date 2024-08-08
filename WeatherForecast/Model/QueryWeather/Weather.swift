//
//  Weather.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct Weather: Decodable, Hashable {
    let id: Double
    let main: String
    let desc: String
    let icon: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case desc = "description"
        case icon = "icon"
    }
}
