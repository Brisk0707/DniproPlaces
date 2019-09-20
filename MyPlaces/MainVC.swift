//
//  MainVC.swift
//  MyPlaces
//
//  Created by Борис Крисько on 9/16/19.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    
    let restaurantNames = [
        "Le Grill", "Репортеръ", "Мамой клянусь", "Мыши Бляхера",
        "Varburger", "Артист", "Puri Chveni", "Хан-Чинар",
        "Casta", "Confetti", "Roadhouse", "Double bar",
        "Эдбрург", "MAFIA", "Lumber"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameOfPlaceLabel.text = restaurantNames[indexPath.row]
        
        cell.imageOfPlace.image = UIImage(named: restaurantNames[indexPath.row])
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    

    

}
