//
//  ExploreViewModel.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 7/29/25.
//

import Foundation

// folows standard dependency injection architecture (to populate our view with data
    // goes with Swift Networking
class ExploreViewModel: ObservableObject {
    @Published var listings = [Listing]() // this var is ultimately displaying the listing set
    @Published var searchLocation = "" // this proeprty is shared amongst all views
    private let service: ExploreService
    private var listingCopy = [Listing]() // var property to keep a copy of listings
    
    init(service: ExploreService) {
        // injecting view model with the service
        self.service = service
        
        Task { await fetchListings() }
    }
    
    // fx to fetch listings
    func fetchListings() async {
        do {
            self.listings = try await service.fetchListings()
            self.listingCopy = listings
        } catch {
            print("DEBUG: Failed to fetch listings with error: \(error.localizedDescription)")
        }
    }
    // filtering listings based on location ~
    // allowing the user to search via city and state
    func updateListingsForLocation(){
        let filteredListings = listings.filter({
            $0.city.lowercased() == searchLocation.lowercased() ||
            $0.state.lowercased() == searchLocation.lowercased()
        })
        // incase a use searches for a listing in a location that we dont have
        // we use a copy here as it: resets it to the orignial set of Listings
        self.listings = filteredListings.isEmpty ? listingCopy: filteredListings
        
    }
}
