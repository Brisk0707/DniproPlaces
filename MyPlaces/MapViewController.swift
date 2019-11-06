//
//  MapViewController.swift
//  MyPlaces
//
//  Created by Борис Крисько on 28.10.2019.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var place = Place()
    var annotationIdentifier = "annotationIdentifier"
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlacemark()
        mapView.delegate = self //setting delegate
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
            
            let placemark = placemarks.first
            
            let annotantion = MKPointAnnotation() //making annotantion
            annotantion.title = self.place.name //add properties to annotation
            annotantion.subtitle = self.place.type
        
            guard let placemarkLocation = placemark?.location else { return }
            
            annotantion.coordinate = placemarkLocation.coordinate
            
            
            self.mapView.showAnnotations([annotantion], animated: true)
            self.mapView.selectAnnotation(annotantion, animated: true)
            
            
        }
    }
    private func checkLocationServices() {
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
        } else {
            //alert controller
        }
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAutorization() {
//        switch CLLocationManager.authorizationStatus() {
//        case .:
//            <#code#>
//        default:
//            <#code#>
//        }
    }
}

extension MapViewController: MKMapViewDelegate { //working with area of annotations
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
        }
        
        if let imageData = place.imageData {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.image = UIImage(data: imageData)
            annotationView?.rightCalloutAccessoryView = imageView
        }
        
        
        
        return annotationView
    }
    
}

