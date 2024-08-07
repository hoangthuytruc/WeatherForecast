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
        let backgroundView = UIImageView(image: UIImage(named: "backgroundImage"))
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.frame = view.frame
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .clear
        navigationBar.tintColor = .black
        
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.shadowColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
