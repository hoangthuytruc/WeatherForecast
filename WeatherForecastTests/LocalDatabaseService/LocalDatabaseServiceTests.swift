//
//  LocalDatabaseServiceTests.swift
//  WeatherForecastTests
//
//  Created by httruc on 28/02/2021.
//

import XCTest
@testable import WeatherForecast

class LocalDatabaseServiceTests: XCTestCase {
    var localDataService: LocalDatabaseService!
    
    override func setUp() {
        super.setUp()
        localDataService = LocalDatabaseService.shared
    }
    
    func testInsertAndGetWeatherObjectsSuccess() {
        // Given
        let response = Helper.getQueryWeatherResponse(at: "saigon")
        
        // When
        localDataService.insertWeatherObjects(
            at: response.city,
            objects: response.weatherItems,
            with: "saigon"
        ) {
            // Then
            self.localDataService.getWeatherObjects(
                at: "saigon") { (items) in
                XCTAssertNotNil(items)
                XCTAssertTrue(items == response.weatherItems)
            }
        }
    }
    
    func testGetWeatherObjectByCity() {
        // Given
        let response = Helper.getQueryWeatherResponse(at: "saigon")
        
        // When
        localDataService.insertWeatherObjects(
            at: response.city,
            objects: response.weatherItems,
            with: "saigon") {
            
            // Then
            self.localDataService.getWeatherObjects(
                at: "saigon") { (items) in
                XCTAssertNotNil(items)
                XCTAssertTrue(items! == response.weatherItems)
            }
        }
    }
    
    func testGetWeatherObjectByPartOfCityName() {
        // Given
        let response = Helper.getQueryWeatherResponse(at: "saigon")
        
        // When
        localDataService.insertWeatherObjects(
            at: response.city,
            objects: response.weatherItems,
            with: "saigon") {
            
            // Then
            self.localDataService.getWeatherObjects(
                at: "saig") { (items) in
                XCTAssertNotNil(items)
                XCTAssertTrue(items! == response.weatherItems)
            }
        }
    }
    
    func testClearLocalDatabaseService() {
        // Given
        let response = Helper.getQueryWeatherResponse(at: "saigon")
        
        // When
        localDataService.insertWeatherObjects(
            at: response.city,
            objects: response.weatherItems,
            with: "saigon"
        ) {
            // Then
            self.localDataService.getWeatherObjects(
                at: "saigon") { (items) in
                XCTAssertNotNil(items)
            }
        }
        
        // When
        localDataService.clear()
        
        // Then
        localDataService.getWeatherObjects(
            at: "saigon") { (items) in
            XCTAssertNil(items)
        }
    }
    
    func testSynchronousLocalDatabaseService() {
        // Given
        let response = Helper.getQueryWeatherResponse(at: "saigon")

        // When
        localDataService.insertWeatherObjects(
            at: response.city,
            objects: response.weatherItems,
            with: "saigon",
            completionHandler: {
                self.localDataService.getWeatherObjects(
                    at: "sai",
                    completionHandler: { items in
                        XCTAssertNotNil(items)
                        XCTAssertTrue(items! == response.weatherItems)
                    }
                )
            }
        )

        // Then
        DispatchQueue.main.async {
            self.localDataService.getWeatherObjects(
                at: "saigon") { (items) in
                XCTAssertNil(items)
            }
        }
    }
}
