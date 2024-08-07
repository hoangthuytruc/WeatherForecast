//
//  AnyServiceFactory.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation

final class AnyServiceFactory {
    private let _resolve: (Resolver) -> Any
    private let _support: (Any.Type) -> Bool

    init<T: ServiceFactory>(_ serviceFactory: T) {
        self._resolve = { resolver -> Any in
            serviceFactory.resolve(resolver)
        }
        self._support = { $0 == T.ServiceType.self }
    }

    func resolve<ServiceType>(_ resolver: Resolver) -> ServiceType {
        // swiftlint:disable force_cast
        _resolve(resolver) as! ServiceType
        // swiftlint:enable force_cast
    }

    func supports<ServiceType>(_ type: ServiceType.Type) -> Bool {
        _support(type)
    }
}
