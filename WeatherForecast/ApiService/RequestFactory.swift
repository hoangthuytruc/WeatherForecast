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
        pageSize: Int = 7,
        appid: String = Configuration.appID,
        units: Units = .metric,
        lang: Language = Configuration.language) -> QueryWeatherRequest {
        
        QueryWeatherRequest(
            city: city,
            pageSize: pageSize,
            appid: appid,
            units: units,
            language: lang
        )
    }
}


