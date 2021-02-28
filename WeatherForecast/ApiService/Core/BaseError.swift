//
//  BaseError.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

enum BaseError: Error {
    case badRequest
    case network
    case parseJson(Error)
    case unknown
}

extension BaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .network:
            return "No internet connect."
        default:
            return "Oops, something went wrong.\nPlease try later."
        }
    }
}
