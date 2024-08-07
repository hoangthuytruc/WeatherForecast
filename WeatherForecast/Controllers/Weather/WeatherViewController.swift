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
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        viewModel.delegate = self
        
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

extension WeatherViewController: UITableViewDataSource,
                                 UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            as? WeatherCell else {
            return UITableViewCell()
        }
        cell.configureCell(viewModel.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentWeatherDetailViewController(viewModel.items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeCity(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError(_ error: BaseError) {
        show(message: error.localizedDescription)
    }
}

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
