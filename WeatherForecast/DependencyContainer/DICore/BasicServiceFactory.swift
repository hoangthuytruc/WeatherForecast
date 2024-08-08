//
//  BasicServiceFactory.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation

protocol ServiceFactory {
    associatedtype ServiceType
    func resolve(_ resolver: Resolver) -> ServiceType
}

extension ServiceFactory {
    public func supports<T>(_ type: T.Type) -> Bool {
        return type == ServiceType.self
    }
}

struct BasicServiceFactory<ServiceType>: ServiceFactory {
    private let factory: (Resolver) -> ServiceType

    init(_ type: ServiceType.Type, factory: @escaping (Resolver) -> ServiceType) {
        self.factory = factory
    }

    func resolve(_ resolver: Resolver) -> ServiceType {
        factory(resolver)
    }
}
