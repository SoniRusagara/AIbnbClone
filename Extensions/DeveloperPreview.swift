//
//  DeveloperPreview.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 7/28/25.
//

// Mock Listing Data
import Foundation

// TODO: Add atleast 5 items for this array to fill in mock data 
class DeveloperPreview {
    // creating a static shared instance
    static let shared = DeveloperPreview()
    
    // array of Listings
    var listings: [Listing] = [
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            ownerName: "Soni Rusagara",
            ownerImageUrl: "profile-soni",
            numberOfBedrooms: 7,
            numberOfBathrooms: 8,
            numberOfGuests: 12,
            numberOfBeds: 9,
            pricePerNight: 1760,
            rating: 4.97,
            imageUrls: ["listing-1", "listing-2", "listing-3", "listing-4"],
            latitude: 25.7850,
            longitude: -80.1936,
            address: "124 Main St",
            city: "Miami",
            state: "FL",
            title: "Miami Villa",
            type: .villa,
            
            features: [.selfCheckIn, .superHost],
            amenities: [.wifi, .alarmSystem, .balcony, .laundry, .tv]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            ownerName: "Michael Scott",
            ownerImageUrl: "profile-michael", //TODO: add pic
            numberOfBedrooms: 1,
            numberOfBathrooms: 1,
            numberOfGuests: 3,
            numberOfBeds: 2,
            pricePerNight: 224,
            rating: 4.83,
            imageUrls: ["listing-1", "listing-2", "listing-3", "listing-4"], //TODO: add pics
            latitude: 120.3782,
            longitude: -50.8648,
            address: "21 Bayview Drive",
            city: "Miami",
            state: "FL",
            title: "Beachfront Condo",
            type: .apartment,
            
            features: [.selfCheckIn, .superHost],
            amenities: [.wifi, .alarmSystem, .balcony, .laundry, .tv, .office]
            
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            ownerName: "Pam Beesly",
            ownerImageUrl: "profile-pam",  //TODO: add pic
            numberOfBedrooms: 3,
            numberOfBathrooms: 2,
            numberOfGuests: 8,
            numberOfBeds: 4,
            pricePerNight: 194,
            rating: 4.90,
            imageUrls: ["listing-1", "listing-2", "listing-3", "listing-4"],  //TODO: add pics
            latitude: 5.0124,
            longitude: -70.4896,
            address: "Wilton Manors",
            city: "Miami",
            state: "FL",
            title: "Miami Manor",
            type: .villa,
            
            features: [.selfCheckIn, .superHost],
            amenities: [.wifi, .alarmSystem, .balcony, .laundry, .tv, .pool, .office, .kitchen]
            
        )
    ]
}
