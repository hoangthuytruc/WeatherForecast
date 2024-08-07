//
//  CityObject.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation
import RealmSwift

final class City: Object {
    @Persisted var id: Int = 0
    @Persisted var name: String = ""
    
    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}
