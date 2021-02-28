//
//  UIFont+Ext.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import UIKit

extension UIFont {
    @available(iOS 11.0, *)
    public func scale() -> UIFont {
        UIFontMetrics.default.scaledFont(for: self)
    }
}
