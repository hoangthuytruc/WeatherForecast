//
//  LocalDatabaseServiceMock.swift
//  WeatherForecastTests
//
//  Created by httruc on 28/02/2021.
//

import Foundation
@testable import WeatherForecast

class LocalDatabaseServiceMock: LocalDatabaseServiceType {
    var dict: [String: WeatherObject] = [:]
    
    func insertWeatherObjects(
        at city: City,
        objects: [WeatherItem],
        with key: String,
        completionHandler: (() -> Void)?) {
        dict[key] = WeatherObject(city: city, weatherItems: objects)
        completionHandler?()
    }
    
    func getWeatherObjects(
        at city: String,
        completionHandler: @escaping (([WeatherItem]?) -> Void)) {
        completionHandler(dict[city]?.weatherItems)
    }
    
    func clear() {
        dict.removeAll()
    }
}
