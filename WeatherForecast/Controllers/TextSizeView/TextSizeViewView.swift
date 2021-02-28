//
//  TextSizeView.swift
//  WeatherForecast
//
//  Created by httruc on 28/02/2021.
//

import Foundation
import UIKit

protocol TextSizeViewDelegate: class {
    func textSizeDidChange(_ textSize: CGFloat)
}

final class TextSizeView: UIView {
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var textSizeTextField: UITextField!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    weak var delegate: TextSizeViewDelegate?
    
    private let minSize: CGFloat = 14
    private let maxSize: CGFloat = 20
    private var currentSize: CGFloat = 17 {
        didSet {
            adjustTextSize()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
        descLabel.text = "Adjust text size to your preferred reading size below."
        adjustTextSize()
        scaleUIElementsIfNeeded(in: self)
    }
    
    private func adjustTextSize() {
        textSizeTextField.text = "\(Int(currentSize))"
        textSizeTextField.font = textSizeTextField.font?.withSize(currentSize)
        minusButton.isEnabled = currentSize > minSize
        plusButton.isEnabled = currentSize < maxSize
    }
    
    @IBAction func inscrease(_ sender: Any) {
        guard currentSize < maxSize else {
            return
        }
        currentSize += 1
        delegate?.textSizeDidChange(currentSize)
    }
    
    @IBAction func decrease(_ sender: Any) {
        guard currentSize > minSize else {
            return
        }
        currentSize -= 1
        delegate?.textSizeDidChange(currentSize)
    }
}
