//
//  DI.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation
import RealmSwift

protocol ViewcontrollerFactory {
    func makeWeatherListController() -> WeatherViewController
    func makeWeatherDetailController(item: QueryWeatherResponse) -> WeatherDetailViewController
}

final class DependencyContainer: ViewcontrollerFactory {
    static let instance = DependencyContainer()
    
    private let container: Container
    
    private init() {
        self.container = Container()
            .register(ApiServiceType.self, instance: ApiService(host: "api.openweathermap.org"))
            .register(LocalStorageType.self, instance: RealmDatabaseService(realm: try! Realm(configuration: realmConfiguration)))
    }
    
    func makeWeatherListController() -> WeatherViewController {
        let controller = WeatherViewController(
            viewModel: WeatherViewModel(
                apiService: container.resolve(ApiServiceType.self),
                localStorage: container.resolve(LocalStorageType.self)
            ), 
            vcFactory: self
        )
        return controller
    }
    
    func makeWeatherDetailController(item: QueryWeatherResponse) -> WeatherDetailViewController {
        let controller = WeatherDetailViewController(
            viewModel: WeatherDetailViewModel(
                localStorage: container.resolve(LocalStorageType.self),
                item: item
            )
        )
        return controller
    }
}
