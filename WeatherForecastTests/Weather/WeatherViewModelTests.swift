//
//  WeatherViewModelTests.swift
//  WeatherForecastTests
//
//  Created by httruc on 28/02/2021.
//

import XCTest
import RealmSwift
@testable import WeatherForecast

class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var apiServiceMock: ApiServiceMock = .init()
    var localStorage: LocalStorageType!
    
    override func setUp() {
        super.setUp()
        self.localStorage = RealmDatabaseService(realm: try! Realm())
        viewModel = WeatherViewModel(
            apiService: apiServiceMock,
            localStorage: localStorage
        )
        localStorage.deleteAll()
    }
    
    func testGetWeatherAtDefaultCity() {
        // Given
        let weatherResponse = Helper.getQueryWeatherResponse(at: "saigon")
        apiServiceMock.queryWeatherResult = .success(weatherResponse)
        // When
        var weatherItems = [QueryWeatherResponse]()
        viewModel.weatherItems = { items in
            weatherItems = items
        }
        viewModel.getWeather()
        
        // Then
        XCTAssertTrue(weatherItems.count == 1)
        XCTAssert(weatherItems[0].cityId == weatherResponse.cityId)
    }
    
    func testGetWeatherWithSavedCities() {
        // Given
        let weatherResponse = Helper.getQueryWeatherResponse(at: "saigon")
        apiServiceMock.queryWeatherResult = .success(weatherResponse)
        localStorage.create(City(id: weatherResponse.cityId, name: weatherResponse.cityName))
        
        // When
        var weatherItems = [QueryWeatherResponse]()
        viewModel.weatherItems = { items in
            weatherItems = items
        }
        viewModel.getWeather()
        
        // Given
        XCTAssertTrue(weatherItems.count == 1)
        XCTAssert(weatherItems[0].cityId == weatherResponse.cityId)
    }
    
    func testSearchWeather() {
        // Given
        let cityName = "tokyo"
        let weatherResponse = Helper.getQueryWeatherResponse(at: cityName)
        apiServiceMock.queryWeatherResult = .success(weatherResponse)
        
        // When
        var weatherItems = [QueryWeatherResponse]()
        viewModel.weatherItems = { items in
            weatherItems = items
        }
        viewModel.searchWeather(at: cityName) { response in
            // Then
            XCTAssertTrue(response.cityName == cityName)
            XCTAssertTrue(weatherItems.isEmpty)
        }
    }
    
    func testRemoveCity() {
        // Given
        let sgWeatherResponse = Helper.getQueryWeatherResponse(at: "saigon")
        apiServiceMock.queryWeatherResult = .success(sgWeatherResponse)
        viewModel.getWeather()
        localStorage.create(City(id: sgWeatherResponse.cityId, name: sgWeatherResponse.cityName))
        
        let tokyoWeatherResponse = Helper.getQueryWeatherResponse(at: "tokyo")
        apiServiceMock.queryWeatherResult = .success(tokyoWeatherResponse)
        viewModel.getWeather()
        localStorage.create(City(id: tokyoWeatherResponse.cityId, name: tokyoWeatherResponse.cityName))
        
        // When
        viewModel.removeCity(at: 1)
        
        // Then
        let total = localStorage.readAll().count
        XCTAssertTrue(total == 1, "The total of local storage (\(total)) is not equal to 1.")
    }
    
    func testSearchCity() {
        // Given
        let searchText = "Paris"
        
        // When
        viewModel.searchCity(with: searchText) { items in
            // Given
            XCTAssertTrue(!items.isEmpty)
        }
        
    }
}
