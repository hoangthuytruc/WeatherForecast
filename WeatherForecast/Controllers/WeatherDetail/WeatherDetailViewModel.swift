//
//  WeatherDetailViewModel.swift
//  WeatherForecast
//
//  Created by httruc on 6/8/24.
//

import Foundation

protocol WeatherDetailViewModelType {
    var item: QueryWeatherResponse { get }
    var detailItems: [WeatherInfoItem] { get }
}

final class WeatherDetailViewModel: WeatherDetailViewModelType {
    var item: QueryWeatherResponse
    
    var detailItems: [WeatherInfoItem]
    
    init(item: QueryWeatherResponse) {
        self.item = item
        self.detailItems = [
            WeatherInfoItem(
                title: "Feels Like",
                desc: item.detail.feelsLikes.toCelsius()
            ),
            WeatherInfoItem(
                title: "Humidity",
                desc: "\(item.detail.humidity) %"
            ),
            WeatherInfoItem(
                title: "Pressure",
                desc: "\(item.detail.pressure) Pa"
            ),
            WeatherInfoItem(
                title: "Visibility",
                desc: "\(item.visibility) m"
            ),
            WeatherInfoItem(
                title: "Sunset",
                desc: item.sys.sunset.toString()
            ),
            WeatherInfoItem(
                title: "Sunrise",
                desc: item.sys.sunrise.toString()
            ),
            WeatherInfoItem(
                title: "Rain",
                desc: "\(item.rain.lastHour) mm in last 1h"
            ),
            WeatherInfoItem(
                title: "Wind",
                desc: "Speed: \(item.wind.speed) m/s"
            ),
        ]
    }
}
