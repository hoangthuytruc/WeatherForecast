//
//  WeatherViewModelTests.swift
//  WeatherForecastTests
//
//  Created by httruc on 28/02/2021.
//

import XCTest
@testable import WeatherForecast

class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var apiServiceMock: ApiServiceMock = .init()
    var localDatabaseServiceMock: LocalDatabaseServiceMock = .init()
    
    override func setUp() {
        super.setUp()
        viewModel = WeatherViewModel(
            apiService: apiServiceMock,
            localDatabaseService: localDatabaseServiceMock
        )
    }
    
    func testGetWeatherSuccess() {
        // Given
        let response = Helper.getQueryWeatherResponse(at: "saigon")
        apiServiceMock.queryWeatherResult = .success(response)

        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewModel.items.count == 7)
    }
    
    func testGetWeatherFailure() {
        // Given
        apiServiceMock.queryWeatherResult = .failure(.network)
        localDatabaseServiceMock.clear()

        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewModel.items.count == 0)
        localDatabaseServiceMock.getWeatherObjects(at: "saigon") { (items) in
            XCTAssertTrue(items == nil)
        }
    }
    
    func testSearchWeatherByCitySuccess() {
        // Given
        let response = Helper.getQueryWeatherResponse(at: "saigon")
        apiServiceMock.queryWeatherResult = .success(response)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewModel.items.count == 7)
        
        // When
        let searchText = "london"
        localDatabaseServiceMock.insertWeatherObjects(
            at: response.city,
            objects: [response.weatherItems[0]],
            with: searchText,
            completionHandler: nil
        )
        viewModel.searchWeather(at: searchText)
        
        // Then
        XCTAssertTrue(viewModel.items.count == 1)
    }
    
    func testSearchWeatherByCityFailure() {
        // Given
        let response = Helper.getQueryWeatherResponse(at: "saigon")
        apiServiceMock.queryWeatherResult = .success(response)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewModel.items.count == 7)
        
        // When
        let searchText = "london"
        apiServiceMock.queryWeatherResult = .failure(.unknown)
        viewModel.searchWeather(at: searchText)
        
        // Then
        XCTAssertTrue(viewModel.items.isEmpty)
    }
    
    func testSearchEmpty() {
        // Given
        let response = Helper.getQueryWeatherResponse(at: "saigon")
        apiServiceMock.queryWeatherResult = .success(response)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewModel.items.count == 7)
        
        // When
        let searchText = "sg"
        viewModel.searchWeather(at: searchText)
        
        // Then
        XCTAssertTrue(viewModel.items.count == 7)
        
        // When
        localDatabaseServiceMock.insertWeatherObjects(
            at: response.city,
            objects: [response.weatherItems[0]],
            with: "saigon",
            completionHandler: nil
        )
        viewModel.searchWeather(at: "")
        XCTAssertTrue(viewModel.items.count == 1)
    }
}
