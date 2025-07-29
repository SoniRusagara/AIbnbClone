//
//  Regions.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 7/29/25.
//

import CoreLocation

// all the cities you have in your app you can add their cooridnates like LA and miami below --> add the new locations to this extension
extension CLLocationCoordinate2D {
    static var losAngeles = CLLocationCoordinate2D(latitude: 34.0549, longitude: -118.2426)
    static var miami = CLLocationCoordinate2D(latitude: 25.7602, longitude: -80.1959)
    
    // TODO: replace w a function that takes ina city name then gives the region in CLLocationCoordinate2D
    
    // TODO: Add in this function for better functionality
    // returns a region for a particular city
//    func regionForCity(_ name: String) -> CLLocationCoordinate2D {
//        switch name {
//            case "Los Angeles"
//            case "Miami"
//        }
//    }
}
