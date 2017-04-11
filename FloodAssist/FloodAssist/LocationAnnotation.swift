//
//  LocationAnnotation.swift
//  Themis
//
//  Created by Thor on 8/19/16.
//  Copyright © 2016 Thor. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Contacts

class LocationAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    let span: MKCoordinateSpan
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D, span: MKCoordinateSpan) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.span = span
        super.init()
    }
    var subtitle: String? {
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(CNPostalAddressStreetKey) : self.subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}
