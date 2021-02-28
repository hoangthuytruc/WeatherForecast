//
//  UITextField+Ext.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import UIKit

extension UITextField {
    @available (iOS 11, *)
    public func scaled() {
        font = font?.scale()
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
    }
}
