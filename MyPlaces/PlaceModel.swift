//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Борис Крисько on 9/20/19.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import RealmSwift

class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var location : String?
    @objc dynamic var type : String?
    @objc dynamic var imageData: Data?
    
    let restaurantNames = [
        "Le Grill", "Репортеръ", "Мамой клянусь", "Мыши Бляхера",
        "Varburger", "Артист", "Puri Chveni", "Хан-Чинар",
        "Casta", "Confetti", "Roadhouse", "Double bar",
        "Эдбрург", "MAFIA", "Lumber"
    ]
    
    func getPlace(){
        
        for place in restaurantNames {
            
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else { return }
            
            let newPlace = Place()
            
            newPlace.name = place
            newPlace.location = "Dnipro"
            newPlace.type = "Restaurant"
            newPlace.imageData = imageData
            
            StorageManager.saveObject(newPlace)
        }

    }
}
