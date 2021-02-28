//
//  Logger.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

enum Logger {
    public static func log(_ item: Any) {
        #if DEBUG
            print(item)
        #endif
    }
}
