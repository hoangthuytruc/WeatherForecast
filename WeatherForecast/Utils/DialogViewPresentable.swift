//
//  DialogViewPresentable.swift
//  WeatherForecast
//
//  Created by httruc on 28/02/2021.
//

import Foundation
import UIKit

protocol DialogViewPresentable {
    func show(
        title: String,
        message: String,
        closeHandler: (() -> Void)?
    )
}

extension DialogViewPresentable where Self: UIViewController {
    func show(
        title: String = "Weather",
        message: String,
        closeHandler: (() -> Void)? = nil) {
        
        showAlertDialog(
            title: title,
            message: message,
            buttonTitle: "Close",
            actionHandler: closeHandler
        )
    }
    
    private func showAlertDialog(
        title: String,
        message: String,
        buttonTitle: String,
        actionHandler: (() -> Void)?) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(
            title: buttonTitle,
            style: .default,
            handler: { (action) in
                actionHandler?()
            })
        )
        present(alertController, animated: true, completion: nil)
    }
}
