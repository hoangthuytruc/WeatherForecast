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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: WeatherViewModelType
    private var timer: Timer?
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    init(viewModel: WeatherViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        activityIndicator.isHidden = true
        
        tableView.register(
            UINib(nibName: String(describing: WeatherCell.self), bundle: nil),
            forCellReuseIdentifier: "Cell"
        )
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        viewModel.delegate = self
        viewModel.viewDidLoad()
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
        let item = viewModel.items[indexPath.row]
        
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    func viewWillQueryWeather() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func viewDidQueryWeather() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
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
            viewModel.searchWeather(at: text)
        }
    }
}
