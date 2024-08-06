//
//  ItemCell.swift
//  WeatherForecast
//
//  Created by httruc on 6/8/24.
//

import UIKit

struct WeatherInfoItem {
    let title: String
    let desc: String
}

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ item: WeatherInfoItem) {
        titleLabel.text = item.title
        descLabel.text = item.desc
    }

}
