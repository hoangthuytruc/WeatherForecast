//
//  LocalDatabaseServiceType.swift
//  WeatherForecast
//
//  Created by httruc on 28/02/2021.
//

import Foundation

protocol LocalDatabaseServiceType {
    func insertWeatherObjects(
        at city: City,
        objects: [WeatherItem],
        with key: String,
        completionHandler: (() -> Void)?
    )
    
    func getWeatherObjects(
        at city: String,
        completionHandler: @escaping (([WeatherItem]?) -> Void)
    )
    
    func clear()
}
