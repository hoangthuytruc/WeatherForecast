//
//  WeatherViewController.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import UIKit

class WeatherViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: WeatherViewModelType
    private let vcFactory: ViewcontrollerFactory
    private var dataSource: WeatherDataSource?
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    init(viewModel: WeatherViewModelType, vcFactory: ViewcontrollerFactory) {
        self.viewModel = viewModel
        self.vcFactory = vcFactory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        
        tableView.register(
            UINib(nibName: String(describing: WeatherCell.self), bundle: nil),
            forCellReuseIdentifier: "Cell"
        )
        
        dataSource = WeatherDataSource()
        dataSource?.didSelectItemAt = {[weak self] item in
            self?.presentWeatherDetailViewController(item)
        }
        dataSource?.didDeleteRowAt = {[weak self] idx in
            self?.viewModel.removeCity(at: idx)
        }
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        searchBar.delegate = self
        viewModel.delegate = self
        
        viewModel.weatherItems = { [weak self] items in
            self?.dataSource?.items = items
            self?.tableView.reloadData()
        }
        
        viewModel.getWeather()
    }
    
    fileprivate func presentWeatherDetailViewController(_ item: QueryWeatherResponse) {
        let controller = vcFactory.makeWeatherDetailController(item: item)
        present(BaseNavigationController(rootViewController: controller), animated: true)
    }
    
    deinit {
        viewModel.invalidateObservation()
    }
}

// MARK: - WeatherViewModelDelegate
extension WeatherViewController: WeatherViewModelDelegate {
    func showError(_ error: BaseError) {
        show(message: error.localizedDescription)
    }
}

// MARK: - UISearchBarDelegate
extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            viewModel.searchWeather(at: text) { [weak self] response in
                self?.presentWeatherDetailViewController(response)
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.observeChanges()
    }
}
