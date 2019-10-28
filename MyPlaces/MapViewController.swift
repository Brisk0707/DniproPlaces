//
//  MapViewController.swift
//  MyPlaces
//
//  Created by Борис Крисько on 28.10.2019.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var place: Place!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupPlacemark() {
        
        guard let location = place.location else { return }
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else { return }
            
        }
        
    }
}
