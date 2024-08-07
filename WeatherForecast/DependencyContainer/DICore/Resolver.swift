//
//  Resolver.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation

protocol Resolver {
    func resolve<ServiceType>(_ type: ServiceType.Type) -> ServiceType
}

extension Resolver {
    func factory<ServiceType>(for type: ServiceType.Type) -> () -> ServiceType {
        return { self.resolve(type) }
    }
}
