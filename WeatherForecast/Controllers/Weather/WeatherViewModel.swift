//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation
import UIKit

protocol WeatherViewModelType {
    var cities: [City] { get }
    var weatherItems: (([QueryWeatherResponse]) -> Void) { get set }
    var delegate: WeatherViewModelDelegate? { get set }
    
    func getWeather()
    func searchWeather(at city: String, completion: @escaping (QueryWeatherResponse) -> Void)
    func removeCity(at index: Int)
    func filterCities(with name: String) -> [City]
    
    func observeChanges()
    func invalidateObservation()
}

protocol WeatherViewModelDelegate: AnyObject {
    func showError(_ error: BaseError)
}

final class WeatherViewModel: WeatherViewModelType {
    weak var delegate: WeatherViewModelDelegate?
    private let apiService: ApiServiceType
    private let localStorage: LocalStorageType
    
    lazy var cities: [City] = {
        var cities = [City]()
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let items = jsonResult as? [Dictionary<String, AnyObject>] {
                    items.forEach { dict in
                        if let id = dict["id"] as? Int, let name = dict["name"] as? String {
                            cities.append(City(id: id, name: name))
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return cities
    }()
    private var savedCities: [City]
    
    init(apiService: ApiServiceType,
         localStorage: LocalStorageType) {
        self.apiService = apiService
        self.localStorage = localStorage
        self.savedCities = localStorage.readAll()
    }
    
    var weatherItems: (([QueryWeatherResponse]) -> Void) = { _ in }
    
    var items: [QueryWeatherResponse] = [] {
        didSet {
            weatherItems(items)
        }
    }
    
    func getWeather() {
        if savedCities.isEmpty {
            queryWeather(at: "saigon") { [weak self] response in
                self?.items.append(response)
                self?.localStorage.create(City(id: response.cityId, name: response.cityName))
            }
        } else {
            savedCities.forEach({
                queryWeather(at: $0.name) { [weak self] response in
                    self?.items.append(response)
                }
            })
        }
    }
    
    func removeCity(at index: Int) {
        let item = items.remove(at: index)
        localStorage.delete(City(id: item.cityId, name: item.cityName))
    }
    
    func filterCities(with name: String) -> [City] {
        cities.filter({ $0.name.contains(name) })
    }
    
    func observeChanges() {
        localStorage.observe { [weak self] newCity in
            self?.queryWeather(at: newCity.name) { [weak self] response in
                self?.items.append(response)
            }
        }
    }
    
    func invalidateObservation() {
        localStorage.invalidateObservation()
    }
    
    func searchWeather(at city: String, completion: @escaping (QueryWeatherResponse) -> Void) {
        queryWeather(at: city) { completion($0) }
    }
    
    private func queryWeather(at city: String, completion: @escaping ((QueryWeatherResponse) -> Void)) {
        apiService.queryWeather(at: city) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.localStorage.update(City(id: response.cityId, name: response.cityName))
                completion(response)
                
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
