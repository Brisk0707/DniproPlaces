//
//  MainVC.swift
//  MyPlaces
//
//  Created by Борис Крисько on 9/16/19.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    
    
//    var restaurantNames = Place.getPlace()  //[Place(image: "Le Grill", name: "Le Grill", location: "Днепр", type: "Кафе")]

    override func viewDidLoad() {
        super.viewDidLoad()

    }


//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return restaurantNames.count
//    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
//
//        let place = restaurantNames[indexPath.row]
//
//        cell.nameOfPlaceLabel.text = place.name
//        cell.locationOfPlaceLabel.text = place.location
//        cell.typeOfPlaceLabel.text = place.type
//
//        if place.image == nil {
//        cell.imageOfPlace.image = UIImage(named: place.restarauntImage!)
//
//        } else {
//            cell.imageOfPlace.image = place.image
//        }
//
//
//
//
//        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
//        cell.imageOfPlace?.clipsToBounds = true
//        return cell
//    }
    
    @IBAction func unwindSegue(_ unwindSegue : UIStoryboardSegue) {
        
        guard let newPlaceVC = unwindSegue.source as? NewPlaceTableVC else { return }
//        
//        newPlaceVC.saveNewPlace()
//        restaurantNames.append(newPlaceVC.newPlace!)
//        tableView.reloadData()
        
    }
    
  
}


