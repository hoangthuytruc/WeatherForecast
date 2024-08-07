//
//  AppDelegate.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = WeatherViewController(
            viewModel: WeatherViewModel(
                apiService: ApiService.shared
            )
        )
        self.window?.rootViewController = BaseNavigationController(rootViewController: viewController)
        self.window?.makeKeyAndVisible()        
        return true
    }
}

