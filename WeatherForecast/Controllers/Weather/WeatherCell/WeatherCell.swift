//
//  WeatherCell.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempTitleLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureTitleLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityTitleLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descTitleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateTitleLabel.text = "Date:"
        tempTitleLabel.text = "Average Temperature:"
        pressureTitleLabel.text = "Pressure:"
        humidityTitleLabel.text = "Humidity:"
        descTitleLabel.text = "Description:"
        scaleUIElementsIfNeeded(in: self)
    }
    
    func configureCell(_ item: WeatherItem) {
        dateLabel.text = item.date.toString()
        tempLabel.text = item.temps.day.toCelsius()
        pressureLabel.text = "\(item.pressure)"
        humidityLabel.text = "\(item.humidity)%"
        descLabel.text = item.weather.first?.desc
    }
}
