//
//  WeatherDetailViewModel.swift
//  WeatherForecast
//
//  Created by httruc on 6/8/24.
//

import Foundation
import UIKit

protocol WeatherDetailViewModelType {
    var isSavedCity: Bool { get }
    var cityName: String { get }
    var date: Date { get }
    var desc: String { get }
    var temp: Double { get }
    var highestTemp: Double { get }
    var lowestTemp: Double { get }
    var detailItems: [WeatherDetailItem] { get }
    
    func add(completion: @escaping () -> Void)
}

final class WeatherDetailViewModel: WeatherDetailViewModelType {
    private let localStorage: LocalStorageType
    private let item: QueryWeatherResponse
    
    init(localStorage: LocalStorageType, item: QueryWeatherResponse) {
        self.localStorage = localStorage
        self.item = item
    }
    
    var isSavedCity: Bool {
        localStorage.read(item.cityId) != nil
    }
    
    var cityName: String {
        item.cityName
    }
    
    var date: Date {
        item.date
    }
    
    var desc: String {
        item.weather.first?.desc ?? ""
    }
    
    var temp: Double {
        item.detail.temp
    }
    
    var highestTemp: Double {
        item.detail.tempMax
    }
    
    var lowestTemp: Double {
        item.detail.tempMin
    }
    
    var detailItems: [WeatherDetailItem] {
        let items: [WeatherDetailItem] = [
            SquareItem(
                title: "SUNSET",
                desc: item.sys.sunset.toString()
            ),
            SquareItem(
                title: "SUNRISE",
                desc: item.sys.sunrise.toString()
            ),
            SquareItem(
                title: "FEELS LIKE",
                desc: item.detail.feelsLikes.formatted(unit: UnitTemperature.celsius)
            ),
            SquareItem(
                title: "HUMIDITY",
                desc: "\(item.detail.humidity)%"
            ),
            RetangleItem(
                title: "WIND",
                desc: AttributedStringBuilder()
                    .append("Speed: ", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
                    .append(item.wind.speed.formatted(unit: UnitSpeed.milesPerHour), attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .medium)])
                    .build()
            ),
            RetangleItem(
                title: "PRESSURE",
                desc: AttributedStringBuilder()
                    .append(item.detail.pressure.formatted(unit: UnitPressure.hectopascals), attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .medium)])
                    .build()
            ),
            SquareItem(
                title: "VISIBILITY",
                desc: "\(item.visibility.formatted(unit: UnitLength.meters))"
            )
        ]
        return items
    }
    
    func add(completion: @escaping () -> Void) {
        localStorage.create(City(id: item.cityId, name: item.cityName))
        completion()
    }
}
