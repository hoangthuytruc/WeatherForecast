//
//  RealmDatabaseService.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation
import RealmSwift

protocol LocalDatabaseServiceType {

}

final class RealmDatabaseService: LocalDatabaseServiceType {
    private let realm = try! Realm()
    
    static var shared: RealmDatabaseService = {
        let instance = RealmDatabaseService()
        return instance
    }()
    
    private init() { }
    
    func create(_ item: City) {
        do {
            try realm.write {
                let obj = LocalCity()
                obj._id = item.id
                obj.name = item.name
                realm.add(obj)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readAll() -> [City] {
        let objects = realm.objects(LocalCity.self)
        var cities = [City]()
        objects.forEach({
            cities.append(City(id: $0._id, name: $0.name))
        })
        return cities
    }
    
    func update(_ item: City) {
        do {
            let obj = realm.objects(LocalCity.self).first(where: { $0._id == item.id })
            try realm.write {
                obj?.name = item.name
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ item: City) {
        do {
            if let obj = realm.objects(LocalCity.self).first(where: { $0._id == item.id }) {
                try realm.write {
                    realm.delete(obj)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
