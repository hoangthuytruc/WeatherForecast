//
//  Configuration.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

enum Language: Int, Encodable {
    case vietnamese = 0
    case english = 1

    public var code: String {
        switch self {
        case .english:
            return "en"
        case .vietnamese:
            return "vi"
        }
    }
}

final class Configuration {
    static var appID: String = "60c6fbeb4b93ac653c492ba806fc346d"
    static var language: Language = .english
}
