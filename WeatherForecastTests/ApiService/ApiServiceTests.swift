//
//  ApiServiceTests.swift
//  WeatherForecastTests
//
//  Created by httruc on 28/02/2021.
//

import XCTest
@testable import WeatherForecast

class ApiServiceTests: XCTestCase {
    var apiService: ApiService!
    
    override func setUp() {
        super.setUp()
        apiService = ApiService(host: "api.openweathermap.org")
    }
    
    func testGetWeatherSuccess() {
        // Given
        let city = "london"
        let expectation = self.expectation(description: "Get API successfully")
        
        // When
        apiService.queryWeather(
            at: city) { (result) in
            // Then
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
