//
//  BaseViewController.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import UIKit

class BaseViewController: UIViewController, DialogViewPresentable {
    // MARK: - Contructors
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setNeedsStatusBarAppearanceUpdate()
    }
    
    deinit {
        print("Deinit \(type(of: self))")
    }
}
