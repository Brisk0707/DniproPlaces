//
//  MainVC.swift
//  MyPlaces
//
//  Created by Борис Крисько on 9/16/19.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import UIKit
import RealmSwift

class MainVC: UITableViewController {
    
    var restaurantNames: Results<Place>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantNames = realm.objects(Place.self) //filling of array from db

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.isEmpty ? 0 : restaurantNames.count
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            
            StorageManager.deleteObject(self.restaurantNames[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [delete]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let place = restaurantNames[indexPath.row]

        cell.nameOfPlaceLabel.text = place.name
        cell.locationOfPlaceLabel.text = place.location
        cell.typeOfPlaceLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)

        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
    
    @IBAction func unwindSegue(_ unwindSegue : UIStoryboardSegue) {
        
        guard let newPlaceVC = unwindSegue.source as? NewPlaceTableVC else { return }
        newPlaceVC.()
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return} //getting current number of row
            
            let place = restaurantNames[indexPath.row] //getting current record from array
            let newPlaceVC = segue.destination as! NewPlaceTableVC //for data transfering
            newPlaceVC.currentPlace = place //data transfer
        }
    }
    
  
}


