//
//  NumberFormatter.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

extension Double {
    func formatted(unit: Unit) -> String {
        let formatter = MeasurementFormatter()
        let temp = Measurement(value: self, unit: unit)
        
        let numberFormatter = NumberFormatter()
        
        switch unit {
        case is UnitTemperature:
            formatter.unitStyle = .short
            numberFormatter.numberStyle = .none
        
        case is UnitPressure:
            formatter.unitStyle = .medium
            numberFormatter.numberStyle = .decimal
            
        default:
            formatter.unitStyle = .medium
            numberFormatter.numberStyle = .none
        }
        formatter.numberFormatter = numberFormatter

        return formatter.string(from: temp)
    }
}
