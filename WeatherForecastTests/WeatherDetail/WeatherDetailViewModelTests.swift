//
//  WeatherDetailViewModelTests.swift
//  WeatherForecastTests
//
//  Created by httruc on 8/8/24.
//

import XCTest
import RealmSwift
@testable import WeatherForecast

final class WeatherDetailViewModelTests: XCTestCase {
    var weatherItem: QueryWeatherResponse!
    var localStorage: LocalStorageType!
    var viewModel: WeatherDetailViewModelType!
    
    override func setUpWithError() throws {
        self.weatherItem = Helper.getQueryWeatherResponse(at: "saigon")
        self.localStorage = RealmDatabaseService(realm: try! Realm(configuration: Realm.Configuration()))
        self.viewModel = WeatherDetailViewModel(localStorage: localStorage, item: weatherItem)
        localStorage.deleteAll()
    }
    
    func testWeatherDetailItem() {
        XCTAssertFalse(viewModel.isSavedCity)
        XCTAssertTrue(viewModel.cityName == weatherItem.cityName)
        XCTAssertTrue(viewModel.date == weatherItem.date)
        XCTAssertTrue(viewModel.desc == weatherItem.weather.first?.desc ?? "")
        XCTAssertTrue(viewModel.temp == weatherItem.detail.temp)
        XCTAssertTrue(viewModel.highestTemp == weatherItem.detail.tempMax)
        XCTAssertTrue(viewModel.lowestTemp == weatherItem.detail.tempMin)
    }

    func testAdd() throws {
        viewModel.add {
            XCTAssertTrue(self.localStorage.readAll().count == 1, "The total of local storage is not equal to 1")
        }
    }
}
