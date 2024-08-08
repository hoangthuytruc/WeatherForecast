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
    func read(_ id: Int) -> City?
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
        guard read(item.id) == nil else {
            return
        }
        
        do {
            try realm.write {
                let obj = City()
                obj.id = item.id
                obj.name = item.name
                realm.add(obj)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read(_ id: Int) -> City? {
        let object = realm.objects(City.self)
            .first(where: { $0.id == id })
        return object == nil ? nil : City(id: object!.id, name: object!.name)
    }
    
    func update(_ item: City) {
        do {
            let obj = realm.objects(City.self).first(where: { $0.id == item.id || $0.name == item.name })
            try realm.write {
                obj?.id = item.id
                obj?.name = item.name
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ item: City) {
        do {
            if let obj = realm.objects(City.self).first(where: { $0.id == item.id }) {
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
        
        let objects = realm.objects(City.self)
        
        token = objects.observe { [weak self] changes in
            switch changes {
            case .initial(_):
                break
            case .update(_, _, let insertions, _):
                if let newIdx = insertions.first, newIdx > 0,
                    let newObjects = self?.realm.objects(City.self) {
                    if newObjects.count > newIdx {
                        let newObject = newObjects[newIdx]
                        completion(City(id: newObject.id, name: newObject.name))
                    }
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
        let objects = realm.objects(City.self)
        var cities = [City]()
        objects.forEach({
            cities.append(City(id: $0.id, name: $0.name))
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
