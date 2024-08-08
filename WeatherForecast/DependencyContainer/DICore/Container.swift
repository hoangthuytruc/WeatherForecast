//
//  Container.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation

struct Container: Resolver {
    let factories: [AnyServiceFactory]

    init() {
        self.factories = []
    }

    private init(factories: [AnyServiceFactory]) {
        self.factories = factories
    }

    // MARK: Register

    func register<T>(_ interface: T.Type, instance: T) -> Container {
        register(interface) { _ in  instance }
    }

    func register<ServiceType>(
        _ type: ServiceType.Type,
        _ factory: @escaping (Resolver) -> ServiceType) -> Container {
        guard !factories.contains(where: { $0.supports(type) }) else {
            fatalError("This type has already registered")
        }

        let newFactory = BasicServiceFactory<ServiceType>(type, factory: { resolver in
            factory(resolver)
        })
        return .init(factories: factories + [AnyServiceFactory(newFactory)])
    }

    // MARK: Resolver

    func resolve<ServiceType>(_ type: ServiceType.Type) -> ServiceType {
        guard let factory = factories.first(where: { $0.supports(type) }) else {
            fatalError("No suitable factory found")
        }
        return factory.resolve(self)
    }

    func factory<ServiceType>(for type: ServiceType.Type) -> () -> ServiceType {
        guard let factory = factories.first(where: { $0.supports(type) }) else {
            fatalError("No suitable factory found")
        }

        return { factory.resolve(self) }
    }
}
