//
//  ItemCell.swift
//  WeatherForecast
//
//  Created by httruc on 6/8/24.
//

import UIKit

protocol WeatherDetailItem {
    var title: String { get }
}

struct SquareItem: WeatherDetailItem {
    let title: String
    let desc: String
}

class SquareItemCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBlurBackgroundView()
    }
    
    func configureCell(_ item: SquareItem) {
        titleLabel.text = item.title
        descLabel.text = item.desc
    }
}
