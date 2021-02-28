//
//  Date+Ext.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

extension Date {
    func toString(format: String = "E, dd MMM yyyy", timeZone: TimeZone? = nil, locale: Locale? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let locale = locale {
            dateFormatter.locale = locale
        } else {
            dateFormatter.locale = .current
        }
        if let timeZone = timeZone {
            dateFormatter.timeZone = timeZone
        } else {
            dateFormatter.timeZone = .current
        }
        return dateFormatter.string(from: self)
    }
}
