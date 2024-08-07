//
//  RequestFactory.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

enum RequestFactory {
    static func queryWeather(
        at city: String,
        appid: String = Configuration.appID,
        units: Units = .metric,
        lang: Language = Configuration.language) -> QueryWeatherRequest {
        
        QueryWeatherRequest(
            city: city,
            appid: appid,
            units: units,
            language: lang
        )
    }
}


