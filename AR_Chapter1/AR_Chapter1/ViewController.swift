//
//  ViewController.swift
//  AR_Chapter1
//
//  Created by jiao qing on 18/1/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationTV = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        locationTV.text = "Good"
        locationTV.font = UIFont.boldSystemFontOfSize(14)
        locationTV.frame = CGRectMake(20, 100, view.frame.size.width - 40, 200)
        view.addSubview(locationTV)
        
        let locationMg = CLLocationManager()
        locationMg.delegate = self
        locationMg.desiredAccuracy = kCLLocationAccuracyBest
        locationMg.distanceFilter = 500
        locationMg.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        locationTV.text = "Latitude \(newLocation.coordinate.latitude) \nLongitude \(newLocation.coordinate.longitude) \nHeight \(newLocation.verticalAccuracy)"
    }
 
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations{
            locationTV.text = "Latitude \(location.coordinate.latitude) \nLongitude \(location.coordinate.longitude) \nHeight \(location.verticalAccuracy)"
        }
    }
}

