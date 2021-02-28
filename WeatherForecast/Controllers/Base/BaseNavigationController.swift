//
//  BaseNavigationController.swift
//  WeatherForecast
//
//  Created by httruc on 28/02/2021.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .black
        
    }
}
