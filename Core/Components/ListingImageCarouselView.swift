//
//  ListingImageCarouselView.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 7/26/25.
//

import SwiftUI

struct ListingImageCarouselView: View {
    // populate with a listing
    let listing: Listing

    var body: some View {
        // images
        TabView{
            ForEach(listing.imageUrls, id: \.self){ image in
                Image(image)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    ListingImageCarouselView(listing: DeveloperPreview.shared.listings[0])
}
