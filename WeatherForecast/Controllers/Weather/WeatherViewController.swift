//
//  WeatherViewController.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import UIKit

class WeatherViewController: BaseViewController, UISearchResultsUpdating {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: WeatherViewModelType
    private let vcFactory: ViewcontrollerFactory
    private var dataSource: WeatherDataSource?
    private lazy var resultsVC = vcFactory.makeSearchResultsController()
    private var timer: Timer?
        
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
        
        setupSearchController()

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
        
        viewModel.delegate = self
        
        viewModel.weatherItems = { [weak self] items in
            self?.dataSource?.items = items
            self?.tableView.reloadData()
        }
        
        viewModel.getWeather()
        viewModel.observeChanges()
    }
    
    fileprivate func setupSearchController() {
        edgesForExtendedLayout = .top
        extendedLayoutIncludesOpaqueBars = true
        let searchController = UISearchController(searchResultsController: resultsVC)
        searchController.searchBar.placeholder = "Search for a city"
        searchController.searchBar.delegate = self
        if #available(iOS 13.0, *) {
            searchController.showsSearchResultsController = true
        }
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        resultsVC.itemSelected = { [weak self] item in
            self?.viewModel.searchWeather(at: item.name) { response in
                self?.presentWeatherDetailViewController(response)
            }
            searchController.isActive = false
        }
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
            self?.viewModel.searchCity(with: searchText) { items in
                DispatchQueue.main.async {
                    self?.resultsVC.filteredCities = items
                    self?.resultsVC.tableView.reloadData()
                }
            }
        })
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

extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController?.isActive = false
        guard let searchText = searchBar.text else {
            return
        }
        viewModel.searchWeather(at: searchText) { [weak self] response in
            self?.presentWeatherDetailViewController(response)
        }
    }
}
