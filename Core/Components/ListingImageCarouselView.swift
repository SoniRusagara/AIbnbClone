//
//  ListingImageCarouselView.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 7/26/25.
//

import SwiftUI

struct ListingImageCarouselView: View {
    // array for mock data for images
    var Images = [
        "listing-1",
        "listing-2",
        "listing-3",
        "listing-4"
    ]
    
    
    var body: some View {
        // images
        TabView{
            ForEach(Images, id: \.self){ image in
                Image(image)
                    .resizable()
                    .scaledToFill()
            }
        }
            .tabViewStyle(.page)
    }
}

#Preview {
    ListingImageCarouselView()
}
