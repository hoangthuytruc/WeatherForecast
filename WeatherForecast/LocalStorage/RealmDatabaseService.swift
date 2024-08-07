//
//  RealmDatabaseService.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import Foundation
import RealmSwift

protocol LocalStorageType {
    func create(_ item: City)
    func update(_ item: City)
    func delete(_ item: City)
    
    func observe(completion: @escaping (City) -> Void)
    func invalidateObservation()
    
    func readAll() -> [City]
    func deleteAll()
}

final class RealmDatabaseService: LocalStorageType {
    
    private let realm: Realm
    
    private var token: NotificationToken?
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func create(_ item: City) {
        do {
            try realm.write {
                let obj = CityObject()
                obj._id = item.id
                obj.name = item.name
                realm.add(obj)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(_ item: City) {
        do {
            let obj = realm.objects(CityObject.self).first(where: { $0._id == item.id })
            try realm.write {
                obj?.name = item.name
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ item: City) {
        do {
            if let obj = realm.objects(CityObject.self).first(where: { $0._id == item.id }) {
                try realm.write {
                    realm.delete(obj)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func observe(completion: @escaping (City) -> Void) {
        guard token == nil else { return }
        
        let objects = realm.objects(CityObject.self)
        
        token = objects.observe { [weak self] changes in
            switch changes {
            case .initial(let collectionType):
                break
            case .update(let collectionType, let deletions, let insertions, let modifications):
                if let newIdx = insertions.first, let newObj = self?.readAll()[newIdx] {
                    completion(newObj)
                }
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func invalidateObservation() {
        token?.invalidate()
    }
    
    func readAll() -> [City] {
        let objects = realm.objects(CityObject.self)
        var cities = [City]()
        objects.forEach({
            cities.append(City(id: $0._id, name: $0.name))
        })
        return cities
    }
    
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
