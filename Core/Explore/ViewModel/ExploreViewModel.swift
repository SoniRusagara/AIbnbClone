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
    @Published var listings = [Listing]()
    private let service: ExploreService
    
    init(service: ExploreService) {
        // injecting view model with the service
        self.service = service
        
        Task { await fetchListings() }
    }
    
    // fx to fetch listings
    func fetchListings() async {
        do {
            self.listings = try await service.fetchListings()
        } catch {
            print("DEBUG: Failed to fetch listings with error: \(error.localizedDescription)")
            
        }
    }
}
