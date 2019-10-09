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
    
    convenience init(name: String,
                              location: String?,
                              type: String?,
                              imageData: Data?){
        self.init()
        self.name = name
        self.location = location
        self.imageData = imageData
    }
}


