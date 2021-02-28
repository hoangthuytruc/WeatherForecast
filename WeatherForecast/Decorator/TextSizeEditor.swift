//
//  TextSizeEditor.swift
//  WeatherForecast
//
//  Created by httruc on 28/02/2021.
//

import Foundation
import UIKit

class TextSizeDecorator: BaseFontEditor {
    private var editor: UIView
    
    required init(_ editor: UIView) {
        self.editor = editor
    }
    
    override func apply(newTextSize: CGFloat) {
        super.apply(newTextSize: newTextSize)
        editor.subviews.forEach({ view in
            adjustTextSize(newTextSize, in: view)
        })
    }
    
    private func adjustTextSize(_ textSize: CGFloat, in view: UIView) {
        if let label = view as? UILabel {
            label.apply(newTextSize: textSize)
        } else if let textfield = view as? UITextField {
            textfield.apply(newTextSize: textSize)
        } else if !view.subviews.isEmpty {
            view.subviews.forEach({ adjustTextSize(textSize, in: $0) })
        }
    }
}
