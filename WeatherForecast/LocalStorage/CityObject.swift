//
//  CityObject.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation
import RealmSwift

class LocalCity: Object {
    @Persisted(primaryKey: true) var _id: Int
    @Persisted var name: String = ""
}
