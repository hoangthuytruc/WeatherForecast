//
//  Data+Ext.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

extension Data {
    func jsonString() -> String {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []) else {
            return ""
        }

        let options: JSONSerialization.WritingOptions
        if #available(iOS 11.0, *) {
            options = [.sortedKeys, .prettyPrinted]
        } else {
            options = .prettyPrinted
        }

        guard let data = try? JSONSerialization.data(withJSONObject: object, options: options)
        else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
}

extension Encodable {
    func jsonString() -> String {
        let encoder = JSONEncoder()
        if #available(iOS 11.0, *) {
            encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        } else {
            encoder.outputFormatting = .prettyPrinted
        }
        guard let data = try? encoder.encode(self) else {
            return ""
        }
        return String(data: data, encoding: .utf8) ?? ""
    }
}
