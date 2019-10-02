//
//  MainVC.swift
//  MyPlaces
//
//  Created by Борис Крисько on 9/16/19.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    
    
    let restaurantNames = Place.getPlace()  //[Place(image: "Le Grill", name: "Le Grill", location: "Днепр", type: "Кафе")]

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameOfPlaceLabel.text = restaurantNames[indexPath.row].name
        cell.locationOfPlaceLabel.text = restaurantNames[indexPath.row].location
        cell.typeOfPlaceLabel.text = restaurantNames[indexPath.row].type
        
        
        cell.imageOfPlace.image = UIImage(named: restaurantNames[indexPath.row].restarauntImage!)
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
    @IBAction func CloseVC(_ segue : UIStoryboardSegue) {}
}
