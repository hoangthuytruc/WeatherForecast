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
    
    let itemsPerRow: CGFloat = 2
    let collectionViewFrame: CGFloat = UIScreen.main.bounds.width
    let margin: CGFloat = 16
    let padding: CGFloat = 8
    var itemSize: CGFloat {
        floor((collectionViewFrame - padding - (2 * margin)) / itemsPerRow)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    init(viewModel: WeatherDetailViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(close)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(add)
        )
        collectionView.register(
            UINib(nibName: String(describing: ItemCell.self), bundle: nil),
            forCellWithReuseIdentifier: "ItemCell"
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        let numberOfItems = CGFloat(viewModel.detailItems.count)
        collectionViewHeightConstraint.constant = itemSize * numberOfItems + padding * (numberOfItems - 1)
        
        layoutOverviewView()
        collectionView.reloadData()
    }
    
    @objc func close() {
        dismiss(animated: true)
    }
    
    @objc func add() {
        
    }
    
    private func layoutOverviewView() {
        let item = viewModel.item
        locationLabel.text = item.cityName
        timeLabel.text = item.date.toString()
        descLabel.text = item.weather.first?.desc.capitalized ?? ""
        highestTempLabel.text = String(format: "H: %@", item.detail.tempMax.formatted(unit: UnitTemperature.celsius))
        lowestTempLabel.text = String(format: "L: %@", item.detail.tempMin.formatted(unit: UnitTemperature.celsius))
        tempLabel.text = item.detail.temp.formatted(unit: UnitTemperature.celsius)
    }
}

extension WeatherDetailViewController: UICollectionViewDataSource, 
                                        UICollectionViewDelegate,
                                        UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.detailItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(viewModel.detailItems[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: itemSize, height: itemSize)
    }
}
