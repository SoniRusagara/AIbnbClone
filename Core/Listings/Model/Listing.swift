//
//  Listing.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 7/28/25.
//

import Foundation

/**
 A data model that represents what a Listing looks like in the app.
 */
struct Listing: Identifiable, Codable {
    let id: String
    // Info for the Owner of the Listing
    let ownerUid: String
    let ownerName: String
    let ownerImageUrl: String
    
    // Num of beds & baths
    let numberOfBedrooms: Int
    let numberOfBathrooms: Int
    let numberOfGuests: Int
    let numberOfBeds: Int
    
    // more listing information
    var pricePerNight: Int
    var rating: Double
    var imageUrls: [String]
    let latitude: Double
    let longitude: Double
    let address: String
    let city: String
    let state: String
    let title: String
    let type: ListingType
    
    // arrays of Listing features & amenities
    var features: [ListingFeatures]
    var amenities: [ListingAmenities]
    
}

// Custom Data Types
//Listing Features & Listing amenities (which are diff structures)

// enum for ListingFeatures
enum ListingFeatures: Int, Codable, Identifiable, Hashable {
    case selfCheckIn
    case superHost
    
    var title: String {
        switch self {
        case .selfCheckIn: return "Self check-in"
        case .superHost: return "Superhost"
        }
    }
    
    var subtitle: String {
        switch self {
        case .selfCheckIn: return "Check yourself in with the keypad."
        case .superHost: return "Superhosts are experienced, highly rated hosts who are commited to providing great experiences for their guests."
        }
    }
    
    var imageName: String {
        switch self {
        case .selfCheckIn: return "door.left.hand.open"
        case .superHost: return "medal"
        }
    }
    
    var id: Int { return self.rawValue}
}

// todo: double check w/ Airbnb for their listing amenities
enum ListingAmenities: Int, Codable, Identifiable, Hashable {
    case pool
    case kitchen
    case wifi
    case laundry
    case tv
    case alarmSystem
    case office
    case balcony
    
    // title associated with each option
    var title: String {
        switch self {
        case .pool: return "Pool"
        case .kitchen: return "Kitchen"
        case .wifi: return "Wifi"
        case .laundry: return "Laundry"
        case .tv: return "TV"
        case .alarmSystem: return "Alarm System"
        case .office: return "Office"
        case .balcony: return "Balcony"
        }
    }
    
    // the image name associated with each option
    var imageName: String {
        switch self {
        case .pool: return "figure.pool.swim"
        case .kitchen: return "fork.knife"
        case .wifi: return "wifi"
        case .laundry: return "washer"
        case .tv: return "tv"
        case .alarmSystem: return "checkerboard.shield"
        case .office: return "pencil.and.ruler.fill"
        case .balcony: return "building"
        }
    }
    
    var id: Int { return self.rawValue}
}

// Listing type enum
enum ListingType: Int, Codable, Identifiable, Hashable {
    case apartment
    case house
    case townHouse
    case villa
    
    var description: String {
        switch self {
        case .apartment: return "Apartment"
        case .house: return "House"
        case .townHouse: return "Town House"
        case .villa: return "Villa"
        }
    }
    
    var id: Int { return self.rawValue }
}

