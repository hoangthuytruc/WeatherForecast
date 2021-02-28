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
    private var textSizeView: TextSizeView?
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    init(viewModel: WeatherViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather Forecast"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_text_size"),
            style: .plain,
            target: self,
            action: #selector(showTextSizeView)
        )
        activityIndicator.isHidden = true
        
        tableView.register(
            UINib(nibName: String(describing: WeatherCell.self), bundle: nil),
            forCellReuseIdentifier: "Cell"
        )
        tableView.dataSource = self
        searchBar.delegate = self
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(dismissTextSizeView)
            )
        )
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    @objc func showTextSizeView() {
        guard textSizeView == nil else {
            return
        }
        textSizeView = TextSizeView.fromNib()
        textSizeView?.delegate = self
        view.insertSubview(textSizeView!, aboveSubview: view)
        NSLayoutConstraint.activate([
            textSizeView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textSizeView!.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func searchWeather() {
        if let text = searchBar.text {
            viewModel.searchWeather(at: text)
        }
    }
    
    @objc func dismissTextSizeView(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: view)
        if let subView = textSizeView,
           !subView.frame.contains(touchPoint) {
            subView.removeFromSuperview()
            textSizeView = nil
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if timer != nil {
            timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(searchWeather),
            userInfo: nil,
            repeats: false
        )
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        viewModel.searchWeather(at: "")
    }
}

extension WeatherViewController: TextSizeViewDelegate {
    func textSizeDidChange(_ textSize: CGFloat) {
        view.subviews.forEach({ view in
            let decorator = TextSizeDecorator(view)
            decorator.apply(newTextSize: textSize)
        })
    }
}
