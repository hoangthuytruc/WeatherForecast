//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation
import UIKit

protocol WeatherViewModelType {
    var items: [WeatherItem] { get }
    var delegate: WeatherViewModelDelegate? { get set }
    
    func viewDidLoad()
    func searchWeather(at city: String)
}

protocol WeatherViewModelDelegate: class {
    func viewWillQueryWeather()
    func viewDidQueryWeather()
    
    func reloadData()
    func showError(_ error: BaseError)
}

final class WeatherViewModel: WeatherViewModelType {
    weak var delegate: WeatherViewModelDelegate?
    private let apiService: ApiServiceType
    private let localDatabaseService: LocalDatabaseServiceType
    private let defaultCity: String
    
    init(apiService: ApiServiceType,
         localDatabaseService: LocalDatabaseServiceType,
         defaultCity: String = "saigon") {
        
        self.apiService = apiService
        self.localDatabaseService = localDatabaseService
        self.defaultCity = defaultCity
    }
    
    var items: [WeatherItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.reloadData()
            }
        }
    }
    
    func viewDidLoad() {
        getWeather(at: defaultCity)
    }
    
    func searchWeather(at city: String) {
        guard !city.isEmpty else {
            getWeather(at: defaultCity)
            return
        }
        
        guard city.count > 2 else {
            return
        }
        getWeather(at: city)
    }
    
    private func getWeather(at city: String) {
        delegate?.viewWillQueryWeather()
        localDatabaseService.getWeatherObjects(at: city) { [weak self] (items) in
            if let items = items {
                self?.items = items
                self?.delegate?.viewDidQueryWeather()
            } else {
                self?.queryWeather(at: city)
            }
        }
    }
    
    private func queryWeather(at city: String) {
        apiService.queryWeather(at: city) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.localDatabaseService.insertWeatherObjects(
                    at: response.city,
                    objects: response.weatherItems,
                    with: city,
                    completionHandler: {
                        self?.getWeather(at: city)
                    }
                )
                
            case .failure(let error):
                self?.items = []
                self?.delegate?.viewDidQueryWeather()
                self?.delegate?.showError(error)
            }
        }
    }
}
