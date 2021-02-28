//
//  UILabel+Ext.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import UIKit

extension UILabel {
    @available(iOS 11.0, *)
    public func scaled() {
        font = font.scale()
        adjustsFontSizeToFitWidth = true
        adjustsFontForContentSizeCategory = true
    }
}
