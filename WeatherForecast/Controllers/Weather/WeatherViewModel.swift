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
    
    func viewDidLoad()
    func searchWeather(at city: String)
}

protocol WeatherViewModelDelegate: AnyObject {
    func viewWillQueryWeather()
    func viewDidQueryWeather()
    
    func reloadData()
    func showError(_ error: BaseError)
}

final class WeatherViewModel: WeatherViewModelType {
    weak var delegate: WeatherViewModelDelegate?
    private let apiService: ApiServiceType
    private let defaultCity: String
    
    init(apiService: ApiServiceType,
         defaultCity: String = "saigon") {
        
        self.apiService = apiService
        self.defaultCity = defaultCity
    }
    
    var items: [QueryWeatherResponse] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.reloadData()
            }
        }
    }
    
    func viewDidLoad() {
        queryWeather(at: defaultCity)
    }
    
    func searchWeather(at city: String) {
        queryWeather(at: city)
    }
    
    private func queryWeather(at city: String) {
        apiService.queryWeather(at: city) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.items.append(response)
                self?.delegate?.viewDidQueryWeather()
                
            case .failure(let error):
                self?.delegate?.viewDidQueryWeather()
                self?.delegate?.showError(error)
            }
        }
    }
}
