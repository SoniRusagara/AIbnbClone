//
//  ExploreService.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 7/29/25.
//

import Foundation

class ExploreService {
    // this is a mock service of fetching listings from an API
    func fetchListings() async throws -> [Listing] {
        return DeveloperPreview().listings // to remove/avoid initiazling a Developer Preview object we would create a shared state object in DevPrev and use it here instead. TODO: look into exactly what code would be required for that 
        
    }
}
