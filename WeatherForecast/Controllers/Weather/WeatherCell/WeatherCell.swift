//
//  WeatherCell.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var highestTempLabel: UILabel!
    @IBOutlet weak var lowestTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBlurBackgroundView()
    }
    
    func configureCell(_ item: QueryWeatherResponse) {
        locationLabel.text = item.cityName
        timeLabel.text = item.date.toString()
        descLabel.text = item.weather.first?.desc.capitalized ?? ""
        highestTempLabel.text = String(format: "H: %@", item.detail.tempMax.formatted(unit: UnitTemperature.celsius))
        lowestTempLabel.text = String(format: "L: %@", item.detail.tempMin.formatted(unit: UnitTemperature.celsius))
        tempLabel.text = item.detail.temp.formatted(unit: UnitTemperature.celsius)
    }
}
