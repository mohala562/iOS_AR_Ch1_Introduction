//
//  MapAnnotation.swift
//  AR_Chapter1
//
//  Created by jiao qing on 19/1/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2DMake(0, 0)
    var title: String?
    var subtitle: String?
    
    init(coord : CLLocationCoordinate2D) {
        super.init()
        
        coordinate = coord
    }
}
