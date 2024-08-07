//
//  WeatherDetailViewModel.swift
//  WeatherForecast
//
//  Created by httruc on 6/8/24.
//

import Foundation
import UIKit

protocol WeatherDetailViewModelType {
    var item: QueryWeatherResponse { get }
    var detailItems: [WeatherDetailItem] { get }
}

final class WeatherDetailViewModel: WeatherDetailViewModelType {
    var item: QueryWeatherResponse
    
    var detailItems: [WeatherDetailItem]
    
    init(item: QueryWeatherResponse) {
        self.item = item
        self.detailItems = [
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
    }
}
