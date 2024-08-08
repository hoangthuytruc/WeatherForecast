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

extension City {
    override var description: String {
        "\(name) (Id: \(id)"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? City {
            return self.id == object.id && self.name == object.name
        } else {
            return super.isEqual(object)
        }
    }
}
