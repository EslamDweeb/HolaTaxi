//
//  PassengerAnnotation.swift
//  HolaTaxi
//
//  Created by eslam dweeb on 6/10/18.
//  Copyright © 2018 eslam dweeb. All rights reserved.
//

import Foundation
import MapKit

class PassengerAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, withKey key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
}
