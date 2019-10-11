//
//  DataManager.swift
//  MyPlaces
//
//  Created by Борис Крисько on 10/5/19.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveNewPlace (_ place: Place) {
        
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deleteObject (_ place: Place) {
        
        try! realm.write {
            realm.delete(place)
        }
    }
}
