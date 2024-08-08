//
//  RetangleItemCell.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import UIKit

struct RetangleItem: WeatherDetailItem {
    let title: String
    let desc: NSAttributedString
}

class RetangleItemCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBlurBackgroundView()
    }
    
    func configureCell(_ item: RetangleItem) {
        titleLabel.text = item.title
        descLabel.attributedText = item.desc
    }
}
