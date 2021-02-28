//
//  NumberFormatter.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

extension Double {
    func toCelsius() -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.numberStyle = .none
        formatter.unitStyle = .medium
        let temp = Measurement(value: Double(floor(self)), unit: UnitTemperature.celsius)
        
        return temp.description.replacingOccurrences(of: ".0", with: "")
    }
}
