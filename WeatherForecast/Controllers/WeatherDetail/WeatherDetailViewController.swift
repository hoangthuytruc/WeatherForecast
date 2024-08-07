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
        
        collectionView.register(
            UINib(nibName: String(describing: SquareItemCell.self), bundle: nil),
            forCellWithReuseIdentifier: "SquareItemCell"
        )
        collectionView.register(
            UINib(nibName: String(describing: RetangleItemCell.self), bundle: nil),
            forCellWithReuseIdentifier: "RetangleItemCell"
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        contentSizeObservation = collectionView.observe(\.contentSize, options: [.new, .old]) { [weak self] (collectionView, change) in
            if let newSize = change.newValue {
                self?.collectionViewHeightConstraint.constant = newSize.height
            }
        }
        layoutOverviewView()
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

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension WeatherDetailViewController: UICollectionViewDataSource,
                                        UICollectionViewDelegate,
                                        UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.detailItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.detailItems[indexPath.row]
        switch item {
        case is SquareItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SquareItemCell", for: indexPath) as? SquareItemCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item as! SquareItem)
            return cell
        case is RetangleItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RetangleItemCell", for: indexPath) as? RetangleItemCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item as! RetangleItem)
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let collectionViewFrame: CGFloat = UIScreen.main.bounds.width
        let margin: CGFloat = 16
        let padding: CGFloat = 8
        let halfSize: CGFloat = floor((collectionViewFrame - padding - (2 * margin)) / itemsPerRow)
        let fullSize: CGFloat = floor(collectionViewFrame - (2 * margin))
        
        let item = viewModel.detailItems[indexPath.row]
        switch item {
        case is SquareItem:
            let titleHeight = item.title.estimateHeight(for: UIFont.systemFont(ofSize: 14), width: halfSize)
            let descHeight = (item as! SquareItem).desc.estimateHeight(for: UIFont.systemFont(ofSize: 36), width: halfSize)
            return CGSize(width: halfSize, height: titleHeight + descHeight + padding * 2)
        case is RetangleItem:
            let titleHeight = item.title.estimateHeight(for: UIFont.systemFont(ofSize: 14), width: fullSize)
            let descHeight = (item as! RetangleItem).desc.string.estimateHeight(for: UIFont.systemFont(ofSize: 36), width: fullSize)
            return CGSize(width: fullSize, height: titleHeight + descHeight + padding * 2)
        default:
            return .zero
        }
        
    }
}
