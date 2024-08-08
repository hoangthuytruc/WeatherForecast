//
//  Helper.swift
//  WeatherForecastTests
//
//  Created by httruc on 8/8/24.
//

import Foundation
@testable import WeatherForecast

enum Helper {
    private static func getDataMock(fileData: String) -> Data {
        let dataUrl = Bundle.main.url(
            forResource: fileData,
            withExtension: "json")!
        let data = try! Data(contentsOf: dataUrl)
        return data
    }

    static func getQueryWeatherResponse(at city: String) -> QueryWeatherResponse {
        let data = getDataMock(fileData: "\(city)")
        let object = try! JSONDecoder().decode(QueryWeatherResponse.self, from: data)
        return object
    }
}
