//
//  LocalDatabaseServiceTests.swift
//  WeatherForecastTests
//
//  Created by httruc on 28/02/2021.
//

import XCTest
import RealmSwift

@testable import WeatherForecast

class LocalDatabaseServiceTests: XCTestCase {
    var localDataService: RealmDatabaseService!
    
    override func setUp() {
        super.setUp()
        self.localDataService = RealmDatabaseService(realm: try! Realm())
    }
    
    func testCreation() {
        let city = City(id: 0, name: "saigon")
        localDataService.create(city)
        let savedCity = localDataService.read(0)
        XCTAssertNotNil(savedCity)
        XCTAssertTrue(city.isEqual(savedCity!), "The saved city [\(savedCity!.description)] does not equal to the original one [\(city.description)].")
    }
    
    func testRead() {
        let city = City(id: 1, name: "tokyo")
        localDataService.create(city)
        let savedCity = localDataService.read(1)
        XCTAssertNotNil(savedCity)
        XCTAssertNil(localDataService.read(2))
        XCTAssertTrue(city.isEqual(savedCity!), "The saved city [\(savedCity!.description)] does not equal to the original one [\(city.description)].")
    }
    
    func testUpdate() {
        let city = City(id: 1, name: "paris")
        localDataService.update(city)
        let savedCity = localDataService.read(1)
        XCTAssertNotNil(savedCity)
        XCTAssertTrue(city.isEqual(savedCity!), "The saved city [\(savedCity!.description)] does not equal to the original one [\(city.description)].")
    }
    
    func testDelete() {
        let city = City(id: 0, name: "saigon")
        localDataService.delete(city)
        XCTAssertNil(localDataService.read(0))
    }
    
    func testReadAll() {
        let total = localDataService.readAll().count
        XCTAssertTrue(total == 1, "The total of saved items (\(total)) does not equal to 1.")
    }
    
    func testDeleteAll() {
        localDataService.deleteAll()
        let total = localDataService.readAll().count
        XCTAssertTrue(total == 0, "The local storage is not empty.")
    }
    
    func testChangesObservation() {
        let city1 = City(id: 0, name: "saigon")
        let city2 = City(id: 1, name: "hanoi")
        let city3 = City(id: 2, name: "bmt")
        localDataService.create(city1)
        localDataService.create(city2)
        localDataService.observe { city in
            let savedCity = self.localDataService.read(3)
            XCTAssertNotNil(savedCity)
            XCTAssertTrue(savedCity!.isEqual(city3), "The saved city [\(savedCity!.description)] does not equal to the original one [\(city3.description)].")
        }
        localDataService.create(city3)
        localDataService.invalidateObservation()
        let city4 = City(id: 3, name: "hue")
        localDataService.create(city4)
    }
}
