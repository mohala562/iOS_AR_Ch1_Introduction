//
//  ViewController.swift
//  AR_Chapter1
//
//  Created by jiao qing on 18/1/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    let locationTV = UITextView()
    let mapView = MKMapView()
    let segmentControl = UISegmentedControl(items: ["Standard", "Satellite", "Hybrid"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationTV.text = "Good"
        locationTV.font = UIFont.boldSystemFontOfSize(14)
        locationTV.frame = CGRectMake(20, 35, view.frame.size.width - 40, 100)
        view.addSubview(locationTV)
        
        let locationMg = CLLocationManager()
        locationMg.delegate = self
        locationMg.desiredAccuracy = kCLLocationAccuracyBest
        locationMg.distanceFilter = 500
        locationMg.startUpdatingLocation()
        
        view.addSubview(segmentControl)
        segmentControl.frame = CGRectMake(20, CGRectGetMaxY(locationTV.frame), view.frame.size.width - 40, 30)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: Selector("segmentControlDidTapped:"), forControlEvents: .ValueChanged)
        
        mapView.delegate = self
        mapView.frame = CGRectMake(20, CGRectGetMaxY(segmentControl.frame), view.frame.size.width - 40, 335)
        view.addSubview(mapView)
        
        dispatch_async(concurrentQueue, {
            self.displayMap()
        })
    }
    
    func displayMap(){
        let coords = CLLocationCoordinate2DMake(37.33188, -122.029497)
        let span = MKCoordinateSpanMake(0.002389, 0.005681)
        let region = MKCoordinateRegionMake(coords, span)
        mapView.setRegion(region, animated: true)
        
        let annota = MapAnnotation(coord: coords)
        annota.title = "Apple"
        annota.subtitle = "USA"
        mapView.addAnnotation(annota)
    }
    
    func segmentControlDidTapped(segment : UISegmentedControl){
        switch segment.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Satellite
        case 2:
            mapView.mapType = .Hybrid
        default:
            mapView.mapType = .Standard
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "MyPin")
        annView.animatesDrop = true
        annView.canShowCallout = true
        annView.setSelected(true, animated: true)
        annView.pinColor = .Purple
        annView.calloutOffset = CGPointMake(-50, 5)
        return annView
    }
    
}

extension MapViewController : CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        locationTV.text = "Latitude \(newLocation.coordinate.latitude) \nLongitude \(newLocation.coordinate.longitude) \nHeight \(newLocation.verticalAccuracy)"
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations{
            locationTV.text = "Latitude \(location.coordinate.latitude) \nLongitude \(location.coordinate.longitude) \nHeight \(location.verticalAccuracy)"
        }
    }
}