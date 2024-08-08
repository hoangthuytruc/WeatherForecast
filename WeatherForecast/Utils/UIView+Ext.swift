//
//  UIView+Ext.swift
//  WeatherForecast
//
//  Created by httruc on 28/02/2021.
//

import Foundation
import UIKit

extension UIView {
    private static let bundle = Bundle.main

    class func fromNib(_ nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil, type: self)
    }

    class func fromNib<T: UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T {
        let view: T? = fromNib(nibNameOrNil, type: T.self)
        return view!
    }

    class var nib: UINib? {
        if bundle.path(forResource: nibName, ofType: "nib") != nil {
            return UINib(nibName: nibName, bundle: bundle)
        } else {
            return nil
        }
    }

    class func fromNib<T: UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            name = nibName
        }
        let nibViews = bundle.loadNibNamed(name, owner: nil, options: nil)
        for nibView in nibViews! {
            if let tog = nibView as? T {
                view = tog
            }
        }
        return view
    }

    class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
}

extension UIView {
    func addBlurBackgroundView() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurEffectView)
        sendSubviewToBack(blurEffectView)
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        set (radius) {
            layer.cornerRadius = radius
            layer.masksToBounds = radius > 0
        }

        get {
            layer.cornerRadius
        }
    }
}
