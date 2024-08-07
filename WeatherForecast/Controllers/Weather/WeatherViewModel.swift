//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation
import UIKit

protocol WeatherViewModelType {
    var items: [QueryWeatherResponse] { get }
    var delegate: WeatherViewModelDelegate? { get set }
    
    func getWeather()
    func searchWeather(at city: String, completion: @escaping (QueryWeatherResponse) -> Void)
    func removeCity(at index: Int)
    
    func observeChanges()
    func invalidateObservation()
}

protocol WeatherViewModelDelegate: AnyObject {
    func reloadData()
    func showError(_ error: BaseError)
}

final class WeatherViewModel: WeatherViewModelType {
    weak var delegate: WeatherViewModelDelegate?
    private let apiService: ApiServiceType
    private let localStorage: LocalStorageType
    
    private var cities: [City]
    
    init(apiService: ApiServiceType,
         localStorage: LocalStorageType) {
        self.apiService = apiService
        self.localStorage = localStorage
        self.cities = localStorage.readAll()
    }
    
    var items: [QueryWeatherResponse] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.reloadData()
            }
        }
    }
    
    func getWeather() {
        if cities.isEmpty {
            queryWeather(at: "saigon") { [weak self] response in
                self?.items.append(response)
                self?.localStorage.create(City(id: response.cityId, name: response.cityName))
            }
        } else {
            cities.forEach({
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
