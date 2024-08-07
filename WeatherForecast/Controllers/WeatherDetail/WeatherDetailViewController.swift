//
//  WeatherDetailViewController.swift
//  WeatherForecast
//
//  Created by httruc on 6/8/24.
//

import UIKit

class WeatherDetailViewController: BaseViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var lowestTempLabel: UILabel!
    @IBOutlet weak var highestTempLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    private var viewModel: WeatherDetailViewModelType
    private var contentSizeObservation: NSKeyValueObservation?
    private var dataSource: WeatherDetailDataSource?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    init(viewModel: WeatherDetailViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(close)
        )
        
        if !viewModel.isSavedCity {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Add",
                style: .plain,
                target: self,
                action: #selector(add)
            )
        }
        
        layoutOverviewView()
        
        collectionView.register(
            UINib(nibName: String(describing: SquareItemCell.self), bundle: nil),
            forCellWithReuseIdentifier: "SquareItemCell"
        )
        collectionView.register(
            UINib(nibName: String(describing: RetangleItemCell.self), bundle: nil),
            forCellWithReuseIdentifier: "RetangleItemCell"
        )
        dataSource = WeatherDetailDataSource(items: viewModel.detailItems)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        contentSizeObservation = collectionView.observe(\.contentSize, options: [.new, .old]) { [weak self] (collectionView, change) in
            if let newSize = change.newValue {
                self?.collectionViewHeightConstraint.constant = newSize.height
            }
        }
       
        collectionView.reloadData()
    }
    
    private func layoutOverviewView() {
        locationLabel.text = viewModel.cityName
        timeLabel.text = viewModel.date.toString()
        descLabel.text = viewModel.desc.capitalized
        highestTempLabel.text = String(format: "H: %@", viewModel.highestTemp.formatted(unit: UnitTemperature.celsius))
        lowestTempLabel.text = String(format: "L: %@", viewModel.lowestTemp.formatted(unit: UnitTemperature.celsius))
        tempLabel.text = viewModel.temp.formatted(unit: UnitTemperature.celsius)
    }
    
    @objc func close() {
        dismiss(animated: true)
    }
    
    @objc func add() {
        viewModel.add() {
            self.close()
        }
    }
    
    deinit {
        contentSizeObservation?.invalidate()
    }
}
