//
//  LocalDatabaseService.swift
//  WeatherForecast
//
//  Created by httruc on 28/02/2021.
//

import Foundation

final class LocalDatabaseService: LocalDatabaseServiceType {
    private let serialQueue = DispatchQueue(label: "com.weatherforecast.serial.queue")
    static let shared: LocalDatabaseService = LocalDatabaseService()
    
    private var dict: [String: WeatherObject]
    
    private init() {
        self.dict = [:]
    }
    
    func insertWeatherObjects(
        at city: City,
        objects: [WeatherItem],
        with key: String,
        completionHandler: (() -> Void)?) {
        let _key = key.lowercased()
        serialQueue.async {
            self.dict[_key] = WeatherObject(city: city, weatherItems: objects)
            completionHandler?()
        }
    }
    
    func getWeatherObjects(
        at city: String,
        completionHandler: @escaping (([WeatherItem]?) -> Void)) {
        let _city = city.lowercased()
        serialQueue.async {
            if let object = self.dict[_city] {
                completionHandler(object.weatherItems)
            } else if let object = self.dict.first(where: { $0.key.contains(_city) }) {
                completionHandler(object.value.weatherItems)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func clear() {
        serialQueue.async {
            self.dict.removeAll()
        }
    }
}
