//
//  WeatherDetailDataSource.swift
//  WeatherForecast
//
//  Created by httruc on 8/8/24.
//

import UIKit

final class WeatherDetailDataSource: NSObject,
                                     UICollectionViewDataSource,
                                     UICollectionViewDelegate,
                                     UICollectionViewDelegateFlowLayout {
    
    var items: [WeatherDetailItem]
    
    init(items: [WeatherDetailItem]) {
        self.items = items
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        switch item {
        case let item as SquareItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SquareItemCell", for: indexPath) as? SquareItemCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item)
            return cell
        case let item as RetangleItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RetangleItemCell", for: indexPath) as? RetangleItemCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item)
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
        
        let item = items[indexPath.row]
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
