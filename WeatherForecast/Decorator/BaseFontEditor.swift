//
//  BaseFontEditor.swift
//  WeatherForecast
//
//  Created by httruc on 28/02/2021.
//

import Foundation
import UIKit

protocol FontEditor {
    func apply(newTextSize: CGFloat)
}

class BaseFontEditor: FontEditor {
    func apply(newTextSize: CGFloat) { }
}

extension UILabel: FontEditor {
    func apply(newTextSize: CGFloat) {
        font = font.withSize(newTextSize)
    }
}

extension UITextField: FontEditor {
    func apply(newTextSize: CGFloat) {
        font = font?.withSize(newTextSize)
    }
}
