//
//  QueryWeatherRequest.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

struct QueryWeatherRequest: Encodable {
    let city: String
    let pageSize: Int
    let appid: String
    let units: Units
    let language: Language
    
    func asParams() -> [String: String] {
        ["q": city,
         "cnt": "\(pageSize)",
         "appid": appid,
         "units": units.rawValue,
         "lang": language.code
        ]
    }
}

