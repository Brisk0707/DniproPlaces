//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Борис Крисько on 9/20/19.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import UIKit

struct Place {
    var restarauntImage: String?
    var name : String
    var location : String?
    var type : String?
    var image: UIImage?
    
    static let restaurantNames = [
        "Le Grill", "Репортеръ", "Мамой клянусь", "Мыши Бляхера",
        "Varburger", "Артист", "Puri Chveni", "Хан-Чинар",
        "Casta", "Confetti", "Roadhouse", "Double bar",
        "Эдбрург", "MAFIA", "Lumber"
    ]
    
    static func getPlace() -> [Place] {
        
        var places = [Place]()
        
        for place in restaurantNames {
            
            places.append(Place(restarauntImage: place,
                                name: place,
                                location: "Днепр",
                                type: "Кафе"))
        }
        return places
    }
}
